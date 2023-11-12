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
    
    public enum State: Equatable {
        case emptyHistory(EmptyHistory.State)
        case mainHistory(MainHistory.State)
        
        public init() { self = .emptyHistory(.init()) }
    }
    
    public enum Action: Equatable {
        case presentEmptyHistory
        case presentMainHistory
        
        case emptyHistory(EmptyHistory.Action)
        case mainHistory(MainHistory.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
        .ifCaseLet(/State.emptyHistory, action: /Action.emptyHistory) {
            EmptyHistory()
        }
        .ifCaseLet(/State.mainHistory, action: /Action.mainHistory) {
            MainHistory()
        }
    }
}
