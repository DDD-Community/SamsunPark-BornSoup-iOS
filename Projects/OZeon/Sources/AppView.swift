//
//  AppView.swift
//  OZeon
//
//  Created by 고병학 on 9/30/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import PresentationKit

import SwiftUI

public struct AppView: View {
    public init(store: StoreOf<AppFeature>) {
        self.store = store
    }
    
    let store: StoreOf<AppFeature>
    
    public var body: some View {
        SwitchStore(store) { state in
            switch state {
            case .splash:
                CaseLet(
                    /AppFeature.State.splash,
                    action: AppFeature.Action.splash
                ) { store in
                    SplashView(store: store)
                }
            case .onboarding:
                CaseLet(
                    /AppFeature.State.onboarding,
                    action: AppFeature.Action.onboarding
                ) { store in
                    OnboardingView(store: store)
                }
            }
        }
    }
}
