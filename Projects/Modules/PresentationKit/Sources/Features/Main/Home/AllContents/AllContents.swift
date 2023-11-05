//
//  AllContents.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/10/15.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation
import ComposableArchitecture

public struct AllContens: Reducer {
    public struct State: Equatable {
        public var contentsList: IdentifiedArrayOf<ContentsHorizontalList.State> = []
    }
    
    public enum Action: Equatable {
        case onAppear
        case contentsList(id: ContentsHorizontalList.State.ID, action: ContentsHorizontalList.Action)
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
            ContentsHorizontalList()
        }
    }
}
