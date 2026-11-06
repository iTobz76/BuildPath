import Foundation

/// Daily-streak maths. A "day" is a local date written like "2026-10-21".
/// The web app uses exactly the same rules, so a streak follows you between devices.
enum StreakMath {
    private static func formatter() -> DateFormatter {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "yyyy-MM-dd"
        return f
    }

    static func dayString(_ d: Date) -> String { formatter().string(from: d) }
    static func date(_ s: String) -> Date? { formatter().date(from: s) }

    static func addDays(_ s: String, _ n: Int) -> String? {
        guard let d = date(s), let r = Calendar.current.date(byAdding: .day, value: n, to: d) else { return nil }
        return dayString(r)
    }

    /// Consecutive practised days ending today, or yesterday (so a streak survives until a whole day is missed).
    static func current(_ days: [String], today: String) -> Int {
        let set = Set(days)
        var next: String? = set.contains(today) ? today : addDays(today, -1)
        var count = 0
        while let day = next, set.contains(day) {
            count += 1
            next = addDays(day, -1)
        }
        return count
    }

    /// Longest run of consecutive days anywhere in the list.
    static func best(_ days: [String]) -> Int {
        var best = 0
        var run = 0
        var previous: String? = nil
        for day in days.sorted() {
            if let p = previous, addDays(p, 1) == day { run += 1 } else { run = 1 }
            best = max(best, run)
            previous = day
        }
        return best
    }

    /// Older saves only stored a streak count, so rebuild the days behind it.
    static func seed(streak: Int, lastActive: String?) -> [String] {
        guard streak > 0, let last = lastActive else { return [] }
        return (0..<streak).compactMap { addDays(last, -$0) }.sorted()
    }
}
