import SwiftUI

struct LessonPlayerView: View {
    let lesson: Lesson
    let courseID: String
    let language: String
    @EnvironmentObject private var progress: ProgressStore
    @EnvironmentObject private var sync: SyncManager
    @Environment(\.dismiss) private var dismiss
    @State private var index: Int
    @State private var finished = false
    @StateObject private var attempt = AttemptStore()
    @State private var showTutor = false
    @State private var tutorMode = "stuck"

    init(lesson: Lesson, courseID: String, language: String, startIndex: Int) {
        self.lesson = lesson
        self.courseID = courseID
        self.language = language
        _index = State(initialValue: startIndex)
    }

    var body: some View {
        VStack(spacing: 0) {
            if finished {
                completeView
            } else {
                ProgressView(value: Double(index), total: Double(lesson.steps.count))
                    .padding(.horizontal)
                stepView(lesson.steps[index]).id(lesson.steps[index].id)
            }
        }
        .navigationTitle(lesson.title)
        .navigationBarTitleDisplayMode(.inline)
        .environmentObject(attempt)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if !finished {
                    Button {
                        tutorMode = wantsUnderstandingCheck ? "check" : "stuck"
                        showTutor = true
                    } label: {
                        Label(wantsUnderstandingCheck ? "Check understanding" : "Ask the tutor",
                              systemImage: "questionmark.bubble")
                    }
                }
            }
        }
        .sheet(isPresented: $showTutor) {
            TutorView(mode: tutorMode, courseID: courseID, lessonID: lesson.id,
                      stepID: lesson.steps[index].id, attempt: attempt.text)
                .environmentObject(sync)
        }
    }

    /// On a lesson card, or after a correct answer, the tutor quizzes you. Otherwise it helps you get unstuck.
    private var wantsUnderstandingCheck: Bool {
        lesson.steps[index].kind == .learn || attempt.correct
    }

    @ViewBuilder
    private func stepView(_ step: Step) -> some View {
        switch step.kind {
        case .learn:            LearnStepView(step: step, onNext: advance)
        case .gapFill:          GapFillStepView(step: step, onNext: advance)
        case .reorder:          ReorderStepView(step: step, onNext: advance)
        case .fixBug, .write:   CodeInputStepView(step: step, language: language, onNext: advance)
        }
    }

    private func advance() {
        attempt.text = ""
        attempt.correct = false
        if index + 1 < lesson.steps.count {
            index += 1
            progress.savePosition(index, for: lesson.id)   // survives closing the app
        } else {
            progress.complete(lesson: lesson, xpEarned: lesson.steps.count * 10)
            finished = true
        }
    }

    private var completeView: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "checkmark.seal.fill").font(.system(size: 64)).foregroundStyle(Color.green)
            Text("Lesson complete!").font(.title.bold())
            Text(lesson.buildNote).multilineTextAlignment(.center).foregroundStyle(.secondary)
            Text("+\(lesson.steps.count * 10) XP").font(.headline)
            Spacer()
            Button("Done") { dismiss() }
                .buttonStyle(.borderedProminent).controlSize(.large)
        }
        .padding()
    }
}
