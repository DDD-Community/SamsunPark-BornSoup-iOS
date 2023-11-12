//
//  EmptyHistory.swift
//  PresentationKit
//
//  Created by 고병학 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import Foundation

public struct EmptyHistory: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
        
        var path: StackState<Path.State> = .init()
        
        var isSunBig: Bool = false
    }
    
    public enum Action: Equatable {
        case path(StackAction<Path.State, Path.Action>)
        
        case onDisappear
        case pushWriteHistoryView
        case didTapAddHistory
    }
    
    public struct Path: Reducer {
        public enum State: Equatable {
            case writeHistory(WriteHistory.State)
        }
        
        public enum Action: Equatable {
            case writeHistory(WriteHistory.Action)
        }
        
        public var body: some ReducerOf<Self> {
            Scope(state: /State.writeHistory, action: /Action.writeHistory) {
                WriteHistory()
            }
        }
    }
    
    @Dependency(\.mainQueue) var mainQueue
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onDisappear:
                state.isSunBig = false
                return .none
                
            case .didTapAddHistory:
                state.isSunBig = true
                return .send(.pushWriteHistoryView)
                    .debounce(
                        id: "pushWriteHistoryView",
                        for: 0.5,
                        scheduler: mainQueue
                    )

            case .pushWriteHistoryView:
                state.path.append(.writeHistory(.init()))
                return .none

            case .path(.element(id: _, action: .writeHistory(.didTapConfirmButton))):
                return .none
                
            default:
                return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
