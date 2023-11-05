//
//  Curating.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/09/30.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//
import ComposableArchitecture

import Foundation

public struct Curating: Reducer {
    public struct State: Equatable {
        var contentsList: IdentifiedArrayOf<CurationContent.State> = []
    }
    
    public enum Action: Equatable {
        case onAppear
        case contentsList(id: CurationContent.State.ID, aciton: CurationContent.Action)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .contentsList:
                return .none
            }
        }
        .forEach(\.contentsList, action: /Action.contentsList) {
            CurationContent()
        }
    }
}

extension Curating.State {
    
}
