//
//  EmptyHistory.swift
//  PresentationKit
//
//  Created by 고병학 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

public struct EmptyHistory: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
        
        var isSunBig: Bool = false
    }
    
    public enum Action: Equatable {
        case onDisappear
        
        case didTapAddHistory
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onDisappear:
                state.isSunBig = false
                return .none
                
            case .didTapAddHistory:
                state.isSunBig = true
                return .none
            }
        }
    }
}
