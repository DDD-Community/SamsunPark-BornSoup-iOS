//
//  AllContentsFilter.swift
//  PresentationKit
//
//  Created by 신의연 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation
import ComposableArchitecture
import DomainKit

public struct AllContentsFilter: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public var filterList: [ContentsHorizontalList.State] = []
        
        public init(filterList: [ContentsHorizontalList.State] = []) {
            self.filterList = filterList
        }
    }
    
    public enum Action: Equatable {
        case confirmButtonTapped
        case move(IndexSet, Int)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .confirmButtonTapped:
                return .none
                
            case let .move(source, destination):
                state.filterList.move(fromOffsets: source, toOffset: destination)
                return .none
            }
        }
    }
}
