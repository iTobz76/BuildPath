import Foundation

// Course -> Lesson -> Step. All content lives in JSON strings, so new courses need no UI changes.

struct Course: Codable, Identifiable {
    let id: String
    let language: String        // "swift" or "python"
    let kind: String?           // "project" for guided real-world projects
    let title: String
    let subtitle: String
    let capstone: String        // name of the thing the learner builds
    let capstoneCode: String    // the finished project, shown when the course is complete
    let lessons: [Lesson]
}

struct Lesson: Codable, Identifiable {
    let id: String
    let title: String
    let buildNote: String       // what this lesson adds to the project
    let steps: [Step]
}

enum StepKind: String, Codable { case learn, gapFill, reorder, fixBug, write }

struct Step: Codable, Identifiable {
    let id: String
    let kind: StepKind
    let title: String
    let body: String            // supports **markdown** and `code`
    let code: String?           // learn: snippet, gapFill: template with ___, fixBug: broken code
    let options: [String]?      // gapFill: choices
    let answers: [String]?      // gapFill: one per blank; fixBug/write: accepted solutions
    let lines: [String]?        // reorder: lines in the CORRECT order
    let hint: String?
}

enum CourseLoader {
    /// Add a new course by adding its JSON string to this list.
    static let all: [Course] = [swiftFoundationsJSON, swiftProjectJSON, pythonFoundationsJSON, pythonProjectJSON, htmlFoundationsJSON, htmlProjectJSON].compactMap { (json: String) -> Course? in
        do {
            return try JSONDecoder().decode(Course.self, from: Data(json.utf8))
        } catch {
            print("Course failed to load: \(error)")
            return nil
        }
    }
}

extension String {
    var straightQuotes: String {
        self.replacingOccurrences(of: "\u{201C}", with: "\"")
            .replacingOccurrences(of: "\u{201D}", with: "\"")
            .replacingOccurrences(of: "\u{2018}", with: "'")
            .replacingOccurrences(of: "\u{2019}", with: "'")
    }

    /// Crude MVP answer check for Swift: ignores all whitespace and smart quotes.
    var normalizedCode: String {
        straightQuotes.filter { !$0.isWhitespace }
    }

    /// Answer check for Python: ignores spacing inside a line but keeps relative
    /// indentation (2 spaces and 4 spaces both count as "one level in").
    var normalizedPython: String {
        let lines = straightQuotes
            .replacingOccurrences(of: "\t", with: "    ")
            .components(separatedBy: "\n")
            .filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        let widths = lines.map { $0.prefix(while: { $0 == " " }).count }
        let levels = Array(Set(widths)).sorted()
        return zip(lines, widths).map { line, width in
            "\(levels.firstIndex(of: width) ?? 0)|" + line.filter { !$0.isWhitespace }
        }.joined(separator: "\n")
    }
}

extension String {
    /// HTML answers: ignore whitespace and letter case; treat <br/> like <br>, and ' like ".
    var normalizedHTML: String {
        straightQuotes.lowercased().filter { !$0.isWhitespace }
            .replacingOccurrences(of: "'", with: "\"")
            .replacingOccurrences(of: "/>", with: ">")
    }
}

extension Course {
    var languageLabel: String { language == "html" ? "HTML" : language.capitalized }
}
