import SwiftUI

@main
struct BuildPathApp: App {
    @StateObject private var progress = ProgressStore()
    @StateObject private var sync = SyncManager()
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(progress)
                .environmentObject(sync)
                .task {
                    sync.attach(progress)
                    await sync.run()
                }
        }
        .onChange(of: scenePhase) { _, phase in
            if phase == .active { Task { await sync.run() } }
        }
    }
}
