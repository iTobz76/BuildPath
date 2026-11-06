import SwiftUI

/// The daily streak: current run, best run, and the last 7 days.
struct StreakCard: View {
    @EnvironmentObject private var progress: ProgressStore

    var body: some View {
        let today = StreakMath.dayString(Date())
        let current = progress.currentStreak
        let week = (0..<7).reversed().compactMap { StreakMath.addDays(today, -$0) }
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Label("\(current)-day streak", systemImage: "flame.fill")
                        .font(.headline)
                        .foregroundStyle(Color.orange)
                    Text("Best: \(progress.best) \(progress.best == 1 ? "day" : "days")")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                HStack(spacing: 6) {
                    ForEach(week, id: \.self) { day in
                        dot(for: day, today: today)
                    }
                }
            }
            Text(message(current: current))
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 14))
    }

    private func message(current: Int) -> String {
        if progress.practisedToday { return "You've practised today. See you tomorrow!" }
        return current > 0 ? "Finish any step today to keep your streak alive."
                           : "Finish a step today to start your streak."
    }

    private func dot(for day: String, today: String) -> some View {
        let active = progress.days.contains(day)
        let letter = StreakMath.date(day).map { $0.formatted(.dateTime.weekday(.narrow)) } ?? ""
        return Text(letter)
            .font(.caption2.bold())
            .frame(width: 26, height: 26)
            .background(active ? Color.orange : Color.gray.opacity(0.25), in: Circle())
            .foregroundStyle(active ? Color.white : Color.secondary)
            .overlay(Circle().stroke(Color.blue, lineWidth: day == today ? 2 : 0).padding(-3))
    }
}
