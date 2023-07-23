import SwiftUI
import PresentationKit
import ComposableArchitecture

@main
struct OZeonApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(store: .init(
                initialState: Root.State(),
                reducer: Root()
            ))
        }
    }
}
