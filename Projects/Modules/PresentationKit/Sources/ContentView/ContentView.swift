import SwiftUI

import ComposableArchitecture

public struct ContentView: View {
    
    public init(store: StoreOf<Store>) {
        self.store = store
    }

    let store: StoreOf<Store>
    
    public var body: some View {
        WithViewStore(
            self.store,
            observe: { $0 }
        ) { viewStore in
            VStack {
                HStack {
                    Button("-") {
                        viewStore.send(.minus)
                    }
                    Text("\(viewStore.count)")
                    Button("+") {
                        viewStore.send(.plus)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: .init(
            initialState: Store.State(),
            reducer: Store()
        ))
    }
}
