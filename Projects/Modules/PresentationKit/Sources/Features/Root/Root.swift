//
//  Root.swift
//  PresentationKit
//
//  Created by 고병학 on 2023/09/03.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import Foundation

public struct Root: Reducer {
    public init() {}
    
    public enum State: Equatable {
        case onboarding(Onboarding.State)
        case mainTabBar(MainTabBar.State)
        
        public init() { self = .onboarding(.init()) }
    }
    
    public enum Action {
        case presentOnboarding
        case presentMainTabBar
        
        case onboarding(Onboarding.Action)
        case mainTabBar(MainTabBar.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onboarding(.switchToMainTabBar):
                state = .mainTabBar(.init())
                return .none
                
            default:
                return .none
            }
        }
        .ifCaseLet(/State.onboarding, action: /Action.onboarding) {
            Onboarding()
        }
        .ifCaseLet(/State.mainTabBar, action: /Action.mainTabBar) {
            MainTabBar()
        }
    }
}
