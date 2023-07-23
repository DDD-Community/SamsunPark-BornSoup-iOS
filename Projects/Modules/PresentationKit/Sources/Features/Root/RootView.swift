//
//  RootView.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/07/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct RootView: View {
    
    let store: Store<Root.State, Root.Action>
    
    public init(store: StoreOf<Root>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            switch viewStore.signInStatus {
            case .signed:
                TabView {
                    MainView(
                        store: self.store.scope(
                            state: \.main,
                            action: Root.Action.mainAction
                        )
                    )
                    .tabItem {
                        Image(systemName: "globe")
                        Text("main")
                    }
                    
                    MyView()
                        .tabItem {
                            Image(systemName: "mic.fill")
                            Text("my")
                        }
                }
            case .unsigned:
                SignInView(store: StoreOf<SignIn>(initialState: SignIn.State(), reducer: {
                    SignIn()
                }))
            }   
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            store: Store(
                initialState: Root.State(),
                reducer: {
                    Root()
                })
        )
    }
}
