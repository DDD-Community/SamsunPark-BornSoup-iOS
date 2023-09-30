//
//  App.swift
//  OZeon
//
//  Created by 고병학 on 9/30/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import Foundation

public struct AppFeature: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action {
        case dismissSplashView
        case dismissMainTabView
        case dismissLoginView
        case presentMainTabView
        case presentLoginView
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .dismissSplashView:
                return .none
            default:
                return .none
            }
        }
    }
}
