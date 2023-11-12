//
//  HistoryRoot.swift
//  PresentationKit
//
//  Created by 고병학 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

public struct HistoryRoot: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action: Equatable {
        case refresh
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .refresh:
                print("refresh")
                return .none
            }
        }
    }
}
