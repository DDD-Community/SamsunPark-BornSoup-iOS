import SwiftUI

import PresentationKit

@main
struct OZeonApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: .init(
                initialState: Store.State(),
                reducer: Store()
            ))
        }
    }
}
