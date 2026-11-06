import Foundation

@MainActor
final class ProgressStore: ObservableObject {
    @Published private(set) var xp: Int
    @Published private(set) var completedLessons: Set<String>
    @Published private(set) var positions: [String: Int]   // lesson id -> step to resume at
    @Published private(set) var days: [String]             // every day you practised, "yyyy-MM-dd"
    @Published private(set) var best: Int                  // best daily streak ever
    private let defaults = UserDefaults.standard

    /// Set by SyncManager so local changes get synced.
    var onChange: (() -> Void)?

    var currentStreak: Int { StreakMath.current(days, today: StreakMath.dayString(Date())) }
    var practisedToday: Bool { days.contains(StreakMath.dayString(Date())) }

    init() {
        xp = defaults.integer(forKey: "xp")
        completedLessons = Set(defaults.stringArray(forKey: "completed") ?? [])
        positions = defaults.dictionary(forKey: "positions") as? [String: Int] ?? [:]
        // Older versions stored only a streak count and a last-active date.
        let oldStreak = defaults.integer(forKey: "streak")
        var last = defaults.string(forKey: "lastActive")
        if last == nil, let d = defaults.object(forKey: "lastActive") as? Date { last = StreakMath.dayString(d) }
        let saved = defaults.stringArray(forKey: "days") ?? []
        let allDays = saved.isEmpty ? StreakMath.seed(streak: oldStreak, lastActive: last) : saved
        days = allDays
        best = max(defaults.integer(forKey: "best"), StreakMath.best(allDays), oldStreak)
    }

    // MARK: Resume support

    func position(for lesson: Lesson) -> Int {
        guard let saved = positions[lesson.id] else { return 0 }
        return min(max(saved, 0), lesson.steps.count - 1)
    }

    func isInProgress(_ lesson: Lesson) -> Bool {
        (positions[lesson.id] ?? 0) > 0
    }

    /// Called each time a step is finished, so any finished step counts as practising today.
    func savePosition(_ index: Int, for lessonID: String) {
        positions[lessonID] = index
        touch()
        persist()
        onChange?()
    }

    // MARK: Completion

    func complete(lesson: Lesson, xpEarned: Int) {
        if !completedLessons.contains(lesson.id) { xp += xpEarned }
        completedLessons.insert(lesson.id)
        positions[lesson.id] = nil
        touch()
        persist()
        onChange?()
    }

    // MARK: Sync support

    func snapshot() -> ProgressData {
        ProgressData(xp: xp, streak: currentStreak, best: best, completed: completedLessons.sorted(),
                     positions: positions, lastActive: days.last, days: days)
    }

    func apply(_ data: ProgressData) {
        xp = data.xp
        completedLessons = Set(data.completed)
        positions = data.positions
        days = data.days
        best = max(best, data.best)
        persist()
    }

    // MARK: Internals

    private func touch() {
        let today = StreakMath.dayString(Date())
        if !days.contains(today) {
            days.append(today)
            days.sort()
        }
        best = max(best, StreakMath.best(days), currentStreak)
    }

    private func persist() {
        defaults.set(xp, forKey: "xp")
        defaults.set(Array(completedLessons), forKey: "completed")
        defaults.set(positions, forKey: "positions")
        defaults.set(days, forKey: "days")
        defaults.set(best, forKey: "best")
        // Kept so older versions of the app can still read the streak.
        defaults.set(currentStreak, forKey: "streak")
        defaults.set(days.last, forKey: "lastActive")
    }
}
