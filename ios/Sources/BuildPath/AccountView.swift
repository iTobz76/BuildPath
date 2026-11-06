import SwiftUI

struct AccountView: View {
    @EnvironmentObject private var sync: SyncManager
    @EnvironmentObject private var progress: ProgressStore
    @Environment(\.dismiss) private var dismiss
    @State private var creating = false
    @State private var email = ""
    @State private var password = ""
    @State private var error = ""
    @State private var working = false

    var body: some View {
        NavigationStack {
            Form {
                if sync.isSignedIn { signedIn } else { signInForm }
            }
            .navigationTitle(sync.isSignedIn ? "Account" : (creating ? "Create account" : "Sign in"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) { Button("Close") { dismiss() } }
            }
        }
    }

    @ViewBuilder
    private var signInForm: some View {
        Section {
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            SecureField("Password (8+ characters)", text: $password)
                .textContentType(creating ? .newPassword : .password)
        } header: {
            Text("Sync your progress across your devices.")
        } footer: {
            if !error.isEmpty { Text(error).foregroundStyle(Color.red) }
        }
        Section {
            Button(creating ? "Create account" : "Sign in") { Task { await submit() } }
                .disabled(working || email.isEmpty || password.count < (creating ? 8 : 1))
            Button(creating ? "Have an account? Sign in" : "New here? Create an account") {
                creating.toggle()
                error = ""
            }
        }
    }

    @ViewBuilder
    private var signedIn: some View {
        Section("Signed in as") { Text(sync.email ?? "") }
        Section("Daily streak") {
            Text("🔥 \(progress.currentStreak)-day streak · best \(progress.best)")
        }
        Section("Sync") {
            Text(sync.status.isEmpty ? "Not synced yet" : sync.status).foregroundStyle(.secondary)
            Button("Sync now") { Task { await sync.syncNow() } }.disabled(sync.isBusy)
        }
        Section {
            Button("Sign out", role: .destructive) { sync.signOut() }
        }
    }

    private func submit() async {
        working = true
        error = ""
        defer { working = false }
        let address = email.trimmingCharacters(in: .whitespaces)
        do {
            if creating {
                try await sync.signUp(email: address, password: password)
            } else {
                try await sync.signIn(email: address, password: password)
            }
            password = ""
            dismiss()
        } catch let e as APIError {
            error = e.message
        } catch {
            self.error = "Cannot reach the server."
        }
    }
}
