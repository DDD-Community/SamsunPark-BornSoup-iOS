//
//  RootView.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/07/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

public struct RootView: View {
    
    let store: StoreOf<Root>
    
    public init(store: StoreOf<Root>) {
        self.store = store
    }
    
    public var body: some View {
        SwitchStore(store) { state in
            switch state {
            case .mainTabBar:
                CaseLet(
                    /Root.State.mainTabBar,
                    action: Root.Action.mainTabBar
                ) { store in
                    MainTabBarView(store: store)
                }
            case .onboarding:
                CaseLet(
                    /Root.State.onboarding,
                     action: Root.Action.onboarding
                ) { store in
                    OnboardingView(store: store)
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: Store(initialState: Root.State()) {
            Root()
        })
    }
}
