import SwiftUI

/// What the learner has typed or picked on the current step, so the tutor can see their attempt.
/// `text` is deliberately not @Published, so typing doesn't redraw the whole lesson.
final class AttemptStore: ObservableObject {
    @Published var correct = false     // true once the current step has been answered correctly
    var text = ""
}

struct TutorMessage: Identifiable {
    let id = UUID()
    let role: String                   // "user" or "assistant"
    let content: String
    var isError = false
}

/// One conversation with the tutor. The tutor asks questions instead of giving answers.
@MainActor
final class TutorSession: ObservableObject {
    @Published private(set) var messages: [TutorMessage]
    @Published private(set) var isSending = false
    let mode: String                   // "stuck" or "check"

    init(mode: String) {
        self.mode = mode
        let greeting = mode == "check"
            ? "In your own words: what does this do, and why does it work?"
            : "I won't hand you the answer, but I'll help you find it. What have you tried, and what do you think is going wrong?"
        messages = [TutorMessage(role: "assistant", content: greeting)]
    }

    func send(_ text: String, sync: SyncManager, courseID: String, lessonID: String, stepID: String, attempt: String) async {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, !isSending else { return }
        messages.append(TutorMessage(role: "user", content: trimmed))
        isSending = true
        defer { isSending = false }
        do {
            // The opening greeting and any error bubbles are not part of the conversation the server sees.
            let history = messages.dropFirst().filter { !$0.isError }.map { TutorTurn(role: $0.role, content: $0.content) }
            let reply = try await sync.askTutor(mode: mode, courseID: courseID, lessonID: lessonID,
                                                stepID: stepID, attempt: attempt, messages: history)
            messages.append(TutorMessage(role: "assistant", content: reply))
        } catch let e as APIError {
            messages.append(TutorMessage(role: "assistant", content: Self.friendly(e), isError: true))
        } catch {
            messages.append(TutorMessage(role: "assistant",
                                         content: "I can't reach the server. Check your connection and try again.", isError: true))
        }
    }

    private static func friendly(_ e: APIError) -> String {
        if e.status == 401 || e.status == 403 { return "Please sign in again." }
        if e.status == 429 { return "You've used today's tutor questions. Come back tomorrow!" }
        return e.message
    }
}

struct TutorView: View {
    let courseID: String
    let lessonID: String
    let stepID: String
    let attempt: String
    @EnvironmentObject private var sync: SyncManager
    @Environment(\.dismiss) private var dismiss
    @StateObject private var session: TutorSession
    @State private var draft = ""

    init(mode: String, courseID: String, lessonID: String, stepID: String, attempt: String) {
        self.courseID = courseID
        self.lessonID = lessonID
        self.stepID = stepID
        self.attempt = attempt
        _session = StateObject(wrappedValue: TutorSession(mode: mode))
    }

    var body: some View {
        NavigationStack {
            Group {
                if sync.isSignedIn { chat } else { signedOut }
            }
            .navigationTitle("Tutor")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) { Button("Close") { dismiss() } }
            }
        }
    }

    private var signedOut: some View {
        VStack(spacing: 12) {
            Image(systemName: "questionmark.bubble").font(.largeTitle).foregroundStyle(Color.blue)
            Text("Sign in to use the tutor.").font(.headline)
            Text("It asks you questions to help you work things out yourself. Sign in from the Courses screen (top right).")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding()
    }

    private var chat: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(session.messages) { message in
                            bubble(message).id(message.id)
                        }
                        if session.isSending {
                            Text("Thinking…").foregroundStyle(.secondary).padding(.horizontal)
                        }
                    }
                    .padding()
                }
                .onChange(of: session.messages.count) { _, _ in
                    if let last = session.messages.last {
                        withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                    }
                }
            }
            Divider()
            HStack {
                TextField("Type your answer…", text: $draft, axis: .vertical)
                    .lineLimit(1...4)
                    .textFieldStyle(.roundedBorder)
                Button("Send") { send() }
                    .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || session.isSending)
            }
            .padding()
        }
    }

    private func bubble(_ message: TutorMessage) -> some View {
        let mine = message.role == "user"
        return Text(message.content)
            .padding(10)
            .background(mine ? Color.blue : Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 14))
            .foregroundStyle(mine ? Color.white : Color.primary)
            .frame(maxWidth: .infinity, alignment: mine ? .trailing : .leading)
    }

    private func send() {
        let text = draft
        draft = ""
        Task {
            await session.send(text, sync: sync, courseID: courseID, lessonID: lessonID,
                               stepID: stepID, attempt: attempt)
        }
    }
}
