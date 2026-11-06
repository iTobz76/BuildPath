import SwiftUI

struct CourseView: View {
    let course: Course
    @EnvironmentObject private var progress: ProgressStore

    private var done: Int {
        course.lessons.filter { progress.completedLessons.contains($0.id) }.count
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                Text(course.subtitle).foregroundStyle(.secondary)
                VStack(alignment: .leading, spacing: 6) {
                    Text("Building: \(course.capstone)").font(.headline)
                    ProgressView(value: Double(done), total: Double(course.lessons.count))
                }
                ForEach(Array(course.lessons.enumerated()), id: \.element.id) { i, lesson in
                    let unlocked = i == 0 || progress.completedLessons.contains(course.lessons[i - 1].id)
                    lessonRow(lesson, number: i + 1, unlocked: unlocked)
                }
                if done == course.lessons.count { capstoneCard }
            }
            .padding()
        }
        .navigationTitle(course.title)
    }

    private func lessonRow(_ lesson: Lesson, number: Int, unlocked: Bool) -> some View {
        let isDone = progress.completedLessons.contains(lesson.id)
        let resuming = !isDone && progress.isInProgress(lesson)
        let icon = isDone ? "checkmark.circle.fill" : (unlocked ? "play.circle.fill" : "lock.fill")
        let tint: Color = isDone ? .green : (unlocked ? .blue : .gray)
        let subtitle = resuming
            ? "Resume at step \(progress.position(for: lesson) + 1) of \(lesson.steps.count)"
            : lesson.buildNote
        return NavigationLink {
            LessonPlayerView(lesson: lesson,
                             courseID: course.id,
                             language: course.language,
                             startIndex: progress.position(for: lesson))
        } label: {
            HStack(spacing: 12) {
                Image(systemName: icon).font(.title2).foregroundStyle(tint)
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(number). \(lesson.title)").font(.headline)
                    Text(subtitle).font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding()
            .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
        .disabled(!unlocked)
    }

    private var capstoneCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("You built a \(course.capstone)!", systemImage: "party.popper.fill").font(.headline)
            CodeBlock(text: course.capstoneCode)
            ShareLink(item: course.capstoneCode) {
                Label("Share your build", systemImage: "square.and.arrow.up")
            }
        }
        .padding()
        .background(Color.green.opacity(0.12), in: RoundedRectangle(cornerRadius: 14))
    }
}
