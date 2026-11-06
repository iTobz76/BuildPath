import SwiftUI

enum CheckState { case idle, correct, wrong }

// MARK: - Shared pieces

struct CodeBlock: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(.callout, design: .monospaced))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 10))
            .textSelection(.enabled)
    }
}

struct StepScaffold<Content: View>: View {
    let step: Step
    @ViewBuilder var content: Content
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(step.title).font(.title2.bold())
                Text(LocalizedStringKey(step.body))
                content
            }
            .padding()
        }
    }
}

struct FeedbackBar: View {
    let state: CheckState
    let canCheck: Bool
    let onCheck: () -> Void
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            if state == .correct {
                Label("Correct!", systemImage: "checkmark.circle.fill").foregroundStyle(Color.green)
            } else if state == .wrong {
                Label("Not quite. Try again.", systemImage: "xmark.circle.fill").foregroundStyle(Color.red)
            }
            Button(state == .correct ? "Continue" : "Check") {
                if state == .correct { onNext() } else { onCheck() }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .disabled(state != .correct && !canCheck)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.bar)
    }
}

// MARK: - Learn

struct LearnStepView: View {
    let step: Step
    let onNext: () -> Void
    var body: some View {
        StepScaffold(step: step) {
            if let code = step.code { CodeBlock(text: code) }
        }
        .safeAreaInset(edge: .bottom) {
            Button("Continue", action: onNext)
                .buttonStyle(.borderedProminent).controlSize(.large)
                .frame(maxWidth: .infinity).padding().background(.bar)
        }
    }
}

// MARK: - Gap fill

struct GapFillStepView: View {
    let step: Step
    let onNext: () -> Void
    @EnvironmentObject private var attempt: AttemptStore
    @State private var filled: [String] = []
    @State private var state: CheckState = .idle

    private var parts: [String] { (step.code ?? "").components(separatedBy: "___") }
    private var blanks: Int { max(parts.count - 1, 0) }

    private var display: String {
        var out = ""
        for (i, part) in parts.enumerated() {
            out += part
            if i < blanks { out += "[ " + (i < filled.count ? filled[i] : "___") + " ]" }
        }
        return out
    }

    var body: some View {
        StepScaffold(step: step) {
            CodeBlock(text: display)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))], spacing: 8) {
                ForEach(step.options ?? [], id: \.self) { option in
                    Button {
                        guard filled.count < blanks else { return }
                        filled.append(option)
                        state = .idle
                    } label: {
                        Text(option).font(.system(.callout, design: .monospaced)).frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
            }
            Button("Undo", systemImage: "arrow.uturn.backward") {
                if !filled.isEmpty { filled.removeLast() }
                state = .idle
            }
            .disabled(filled.isEmpty)
        }
        .safeAreaInset(edge: .bottom) {
            FeedbackBar(state: state, canCheck: filled.count == blanks, onCheck: {
                state = filled == (step.answers ?? []) ? .correct : .wrong
            }, onNext: onNext)
        }
        .onChange(of: filled) { _, value in attempt.text = value.joined(separator: ", ") }
        .onChange(of: state) { _, value in attempt.correct = (value == .correct) }
    }
}

// MARK: - Reorder

private struct Line: Identifiable {
    let id = UUID()
    let text: String
}

struct ReorderStepView: View {
    let step: Step
    let onNext: () -> Void
    @EnvironmentObject private var attempt: AttemptStore
    @State private var pool: [Line]
    @State private var chosen: [Line] = []
    @State private var state: CheckState = .idle

    init(step: Step, onNext: @escaping () -> Void) {
        self.step = step
        self.onNext = onNext
        _pool = State(initialValue: (step.lines ?? []).map { Line(text: $0) }.shuffled())
    }

    var body: some View {
        StepScaffold(step: step) {
            Text("Your answer").font(.caption).foregroundStyle(.secondary)
            VStack(spacing: 6) {
                ForEach(chosen) { line in
                    lineButton(line) {
                        chosen.removeAll { $0.id == line.id }
                        pool.append(line)
                        state = .idle
                    }
                }
                if chosen.isEmpty {
                    Text("Tap the lines below to build the code")
                        .foregroundStyle(.secondary).frame(maxWidth: .infinity, minHeight: 44)
                }
            }
            Divider()
            VStack(spacing: 6) {
                ForEach(pool) { line in
                    lineButton(line) {
                        pool.removeAll { $0.id == line.id }
                        chosen.append(line)
                        state = .idle
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            FeedbackBar(state: state, canCheck: pool.isEmpty, onCheck: {
                state = chosen.map(\.text) == (step.lines ?? []) ? .correct : .wrong
            }, onNext: onNext)
        }
        .onChange(of: chosen.map(\.text)) { _, value in attempt.text = value.joined(separator: "\n") }
        .onChange(of: state) { _, value in attempt.correct = (value == .correct) }
    }

    private func lineButton(_ line: Line, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(line.text)
                .font(.system(.callout, design: .monospaced))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 8))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Fix the bug / write it yourself

struct CodeInputStepView: View {
    let step: Step
    let language: String
    let onNext: () -> Void
    @EnvironmentObject private var attempt: AttemptStore
    @State private var text: String
    @State private var state: CheckState = .idle
    @State private var showHint = false

    init(step: Step, language: String, onNext: @escaping () -> Void) {
        self.step = step
        self.language = language
        self.onNext = onNext
        _text = State(initialValue: step.code ?? "")
    }

    var body: some View {
        StepScaffold(step: step) {
            TextEditor(text: $text)
                .font(.system(.callout, design: .monospaced))
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .scrollContentBackground(.hidden)
                .frame(minHeight: 160)
                .padding(8)
                .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 10))
                .onChange(of: text) { state = .idle }
            if let hint = step.hint {
                Button(showHint ? hint : "Show hint") { showHint = true }.font(.footnote)
            }
        }
        .safeAreaInset(edge: .bottom) {
            FeedbackBar(state: state, canCheck: !text.isEmpty, onCheck: {
                func clean(_ s: String) -> String { language == "python" ? s.normalizedPython : (language == "html" ? s.normalizedHTML : s.normalizedCode) }
                let attempt = clean(text)
                state = (step.answers ?? []).contains { clean($0) == attempt } ? .correct : .wrong
            }, onNext: onNext)
        }
        .onAppear { attempt.text = text }
        .onChange(of: text) { _, value in attempt.text = value }
        .onChange(of: state) { _, value in attempt.correct = (value == .correct) }
    }
}
