import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var progress: ProgressStore
    @EnvironmentObject private var sync: SyncManager
    @State private var showAccount = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        Label("\(progress.currentStreak)", systemImage: "flame.fill").foregroundStyle(Color.orange)
                        Spacer()
                        Label("\(progress.xp) XP", systemImage: "star.fill").foregroundStyle(Color.yellow)
                    }
                    StreakCard()
                    Text("Pick a course. Every one ends with something you built.")
                        .foregroundStyle(.secondary)
                    ForEach(CourseLoader.all) { course in
                        NavigationLink {
                            CourseView(course: course)
                        } label: {
                            courseCard(course)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("BuildPath")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(sync.isSignedIn ? "Account" : "Sign in") { showAccount = true }
                }
            }
            .sheet(isPresented: $showAccount) {
                AccountView().environmentObject(sync).environmentObject(progress)
            }
        }
    }

    private func courseCard(_ course: Course) -> some View {
        let done = course.lessons.filter { progress.completedLessons.contains($0.id) }.count
        let started = course.lessons.contains { progress.isInProgress($0) }
        let accent: Color = course.language == "python" ? .blue : (course.language == "html" ? .purple : .orange)
        return VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(course.languageLabel)
                    .font(.caption.bold())
                    .padding(.horizontal, 8).padding(.vertical, 3)
                    .background(accent.opacity(0.2), in: Capsule())
                    .foregroundStyle(accent)
                if course.kind == "project" {
                    Text("Project")
                        .font(.caption.bold())
                        .padding(.horizontal, 8).padding(.vertical, 3)
                        .background(Color.green.opacity(0.2), in: Capsule())
                        .foregroundStyle(Color.green)
                }
                Spacer()
                if done == course.lessons.count {
                    Image(systemName: "checkmark.seal.fill").foregroundStyle(Color.green)
                } else if started {
                    Text("In progress").font(.caption).foregroundStyle(.secondary)
                }
            }
            Text(course.title).font(.title3.bold())
            Text(course.subtitle).font(.subheadline).foregroundStyle(.secondary)
            ProgressView(value: Double(done), total: Double(course.lessons.count)).tint(accent)
            Text("\(done) of \(course.lessons.count) lessons").font(.caption).foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 14))
    }
}
