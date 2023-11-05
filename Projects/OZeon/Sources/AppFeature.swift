//
//  App.swift
//  OZeon
//
//  Created by 고병학 on 9/30/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import PresentationKit

import Foundation

public struct AppFeature: Reducer {
    public init() {}
    
    public enum State: Equatable {
        case splash(Splash.State)
        case root(Root.State)
        
        public init() { self = .splash(Splash.State()) }
    }
    
    public enum Action {
        case presentSplashView
        case presentRootView
        
        case splash(Splash.Action)
        case root(Root.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .splash(.presentRootView):
                return .send(.presentRootView)

            case .presentRootView:
                state = .root(.init())
                return .none

            default:
                return .none
            }
        }
        .ifCaseLet(/State.splash, action: /Action.splash) {
            Splash()
        }
        .ifCaseLet(/State.root, action: /Action.root) {
            Root()
        }
    }
}
