import Foundation

// MARK: - Progress data (same JSON shape the web app stores in the PocketBase "progress" record)

struct ProgressData: Codable, Equatable {
    var xp: Int
    var streak: Int                  // current daily streak, as of the last sync
    var best: Int                    // best daily streak ever
    var completed: [String]
    var positions: [String: Int]     // lesson id -> step to resume at
    var lastActive: String?          // most recent practised day, "yyyy-MM-dd"
    var days: [String]               // every day you practised (the streak is calculated from this)

    enum CodingKeys: String, CodingKey { case xp, streak, best, completed, positions, lastActive, days }

    init(xp: Int = 0, streak: Int = 0, best: Int = 0, completed: [String] = [], positions: [String: Int] = [:],
         lastActive: String? = nil, days: [String] = []) {
        self.xp = xp
        self.streak = streak
        self.best = best
        self.completed = completed
        self.positions = positions
        self.lastActive = lastActive
        self.days = days
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        let savedStreak = try c.decodeIfPresent(Int.self, forKey: .streak) ?? 0
        let last = try c.decodeIfPresent(String.self, forKey: .lastActive)
        let savedDays = try c.decodeIfPresent([String].self, forKey: .days) ?? []
        xp = try c.decodeIfPresent(Int.self, forKey: .xp) ?? 0
        streak = savedStreak
        best = try c.decodeIfPresent(Int.self, forKey: .best) ?? savedStreak
        completed = try c.decodeIfPresent([String].self, forKey: .completed) ?? []
        positions = try c.decodeIfPresent([String: Int].self, forKey: .positions) ?? [:]
        lastActive = last
        // Older saves only had a streak count, so rebuild the days behind it.
        days = savedDays.isEmpty ? StreakMath.seed(streak: savedStreak, lastActive: last) : savedDays
    }
}

/// Combines two devices' progress without losing anything: every completed lesson is kept,
/// the furthest resume step wins, XP is recalculated from completed lessons, and the streak
/// is recalculated from the union of all the days you practised. (Same rules as the web app.)
enum ProgressMerge {
    static func xp(for done: [String]) -> Int {
        CourseLoader.all.flatMap { $0.lessons }
            .filter { done.contains($0.id) }
            .reduce(0) { $0 + $1.steps.count * 10 }
    }

    static func merge(_ a: ProgressData, _ b: ProgressData) -> ProgressData {
        let done = Array(Set(a.completed).union(b.completed)).sorted()
        var pos: [String: Int] = [:]
        for key in Set(a.positions.keys).union(b.positions.keys) where !done.contains(key) {
            pos[key] = max(a.positions[key] ?? 0, b.positions[key] ?? 0)
        }
        let days = Array(Array(Set(a.days).union(b.days)).sorted().suffix(400))
        let streak = StreakMath.current(days, today: StreakMath.dayString(Date()))
        let best = max(a.best, b.best, StreakMath.best(days), streak)
        return ProgressData(xp: xp(for: done), streak: streak, best: best, completed: done,
                            positions: pos, lastActive: days.last, days: days)
    }
}

// MARK: - Talking to PocketBase

struct APIError: LocalizedError {
    let status: Int?
    let message: String
    var errorDescription: String? { message }
}

private struct AuthResponse: Decodable {
    struct Rec: Decodable { let id: String; let email: String }
    let token: String
    let record: Rec
}

private struct ListResponse: Decodable {
    struct Item: Decodable { let id: String; let data: ProgressData? }
    let items: [Item]
}

private struct Ignored: Decodable {}

struct TutorTurn: Encodable {
    let role: String
    let content: String
}
private struct TutorBody: Encodable {
    let mode: String
    let courseId: String
    let lessonId: String
    let stepId: String
    let attempt: String
    let messages: [TutorTurn]
}
private struct TutorReply: Decodable { let reply: String }
private struct CreateBody: Encodable { let user: String; let data: ProgressData }
private struct PatchBody: Encodable { let data: ProgressData }

@MainActor
final class SyncManager: ObservableObject {
    static let baseURL = URL(string: "http://127.0.0.1:8090")!

    @Published private(set) var email: String?
    @Published private(set) var status = ""
    @Published private(set) var isBusy = false

    var isSignedIn: Bool { email != nil }

    private var token: String?
    private var userID: String?
    private var fresh = false                      // token already refreshed this launch
    private var pending: Task<Void, Never>?
    private weak var store: ProgressStore?
    private let defaults = UserDefaults.standard

    init() {
        token = defaults.string(forKey: "sync.token")
        userID = defaults.string(forKey: "sync.uid")
        email = defaults.string(forKey: "sync.email")
    }

    func attach(_ store: ProgressStore) {
        self.store = store
        store.onChange = { [weak self] in self?.schedule() }
    }

    // MARK: Accounts

    func signIn(email: String, password: String) async throws {
        token = nil
        let r = try await call("users/auth-with-password", method: "POST",
                               body: JSONEncoder().encode(["identity": email, "password": password]),
                               as: AuthResponse.self)
        save(r)
        fresh = true
        await run()
    }

    func signUp(email: String, password: String) async throws {
        token = nil
        do {
            _ = try await call("users/records", method: "POST",
                               body: JSONEncoder().encode(["email": email, "password": password, "passwordConfirm": password]),
                               as: Ignored.self)
        } catch let e as APIError where e.message.lowercased().contains("unique") {
            throw APIError(status: e.status, message: "That email already has an account. Try signing in.")
        }
        try await signIn(email: email, password: password)
    }

    func signOut() {
        token = nil
        userID = nil
        email = nil
        fresh = false
        status = ""
        for key in ["sync.token", "sync.uid", "sync.email"] { defaults.removeObject(forKey: key) }
    }

    // MARK: Syncing

    /// Called whenever local progress changes; waits a moment so a burst of changes is one sync.
    func schedule() {
        guard token != nil else { return }
        pending?.cancel()
        pending = Task {
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            if !Task.isCancelled { await run() }
        }
    }

    func syncNow() async {
        fresh = false
        await run()
    }

    func run() async {
        guard let store, token != nil, !isBusy else { return }
        isBusy = true
        defer { isBusy = false }
        do {
            if !fresh {
                do {
                    let r = try await call("users/auth-refresh", method: "POST", as: AuthResponse.self)
                    save(r)
                    fresh = true
                } catch let e as APIError where e.status != nil {
                    signOut()
                    status = "Session expired. Please sign in again."
                    return
                }
            }
            guard let uid = userID else { return }
            let list = try await call("progress/records",
                                      query: [URLQueryItem(name: "perPage", value: "1"),
                                              URLQueryItem(name: "filter", value: "(user=\"\(uid)\")")],
                                      as: ListResponse.self)
            let local = store.snapshot()
            let record = list.items.first
            let remote = record?.data ?? local
            let merged = ProgressMerge.merge(local, remote)
            store.apply(merged)
            if let record {
                if ProgressMerge.merge(remote, remote) != merged {
                    _ = try await call("progress/records/\(record.id)", method: "PATCH",
                                       body: JSONEncoder().encode(PatchBody(data: merged)), as: Ignored.self)
                }
            } else {
                _ = try await call("progress/records", method: "POST",
                                   body: JSONEncoder().encode(CreateBody(user: uid, data: merged)), as: Ignored.self)
            }
            status = "Synced " + Date().formatted(date: .omitted, time: .shortened)
        } catch {
            if error is URLError {
                status = "Offline. Will retry when you are back online."
            } else {
                status = (error as? APIError)?.message ?? "Sync problem. Will retry."
            }
        }
    }

    // MARK: Tutor

    /// Asks the server's AI tutor. The server holds the API key and looks up the lesson itself;
    /// the app only sends ids, the learner's attempt and the conversation so far.
    func askTutor(mode: String, courseID: String, lessonID: String, stepID: String,
                  attempt: String, messages: [TutorTurn]) async throws -> String {
        guard let token else { throw APIError(status: 401, message: "Sign in to use the tutor.") }
        var req = URLRequest(url: Self.baseURL.appendingPathComponent("api/tutor"))
        req.httpMethod = "POST"
        req.timeoutInterval = 100          // a local model can take a while to load on the first question
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue(token, forHTTPHeaderField: "Authorization")
        req.httpBody = try JSONEncoder().encode(TutorBody(mode: mode, courseId: courseID, lessonId: lessonID,
                                                          stepId: stepID, attempt: attempt, messages: messages))
        let (data, response) = try await URLSession.shared.data(for: req)
        let code = (response as? HTTPURLResponse)?.statusCode ?? 0
        guard (200..<300).contains(code) else {
            throw APIError(status: code, message: Self.message(from: data))
        }
        return try JSONDecoder().decode(TutorReply.self, from: data).reply
    }

    // MARK: Plumbing

    private func save(_ r: AuthResponse) {
        token = r.token
        userID = r.record.id
        email = r.record.email
        defaults.set(r.token, forKey: "sync.token")
        defaults.set(r.record.id, forKey: "sync.uid")
        defaults.set(r.record.email, forKey: "sync.email")
    }

    private func call<T: Decodable>(_ path: String, method: String = "GET", query: [URLQueryItem] = [],
                                    body: Data? = nil, as type: T.Type) async throws -> T {
        var comps = URLComponents(url: Self.baseURL.appendingPathComponent("api/collections/" + path),
                                  resolvingAgainstBaseURL: false)!
        if !query.isEmpty { comps.queryItems = query }
        var req = URLRequest(url: comps.url!)
        req.httpMethod = method
        req.timeoutInterval = 20
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token { req.setValue(token, forHTTPHeaderField: "Authorization") }
        req.httpBody = body
        let (data, response) = try await URLSession.shared.data(for: req)
        let code = (response as? HTTPURLResponse)?.statusCode ?? 0
        guard (200..<300).contains(code) else {
            throw APIError(status: code, message: Self.message(from: data))
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

    private static func message(from data: Data) -> String {
        guard let obj = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] else {
            return "Something went wrong"
        }
        if let fields = obj["data"] as? [String: Any],
           let first = fields.values.first as? [String: Any],
           let text = first["message"] as? String {
            return text
        }
        return (obj["message"] as? String) ?? "Something went wrong"
    }
}
