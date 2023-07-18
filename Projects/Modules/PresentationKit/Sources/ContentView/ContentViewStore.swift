//
//  ContentViewStore.swift
//  PresentationKit
//
//  Created by 고병학 on 2023/07/18.
//  Copyright © 2023 kr.byunghak. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

public struct Store: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
        var count: Int = 0
    }
    
    public enum Action: Equatable {
        case plus
        case minus
    }
    
    public func reduce(into state: inout State, action: Action) -> ComposableArchitecture.EffectTask<Action> {
        switch action {
        case .plus:
            state.count += 1
            return .none
        case .minus:
            state.count -= 1
            return .none
        }
    }
}
