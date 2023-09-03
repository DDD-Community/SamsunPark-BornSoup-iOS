import ComposableArchitecture
import PresentationKit

import SwiftUI

@main
struct OZeonApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(store: Store(initialState: Root.State()) {
                Root()
            })
        }
    }
}
