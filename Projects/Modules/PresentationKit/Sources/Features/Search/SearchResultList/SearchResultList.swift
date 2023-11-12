//
//  SearchResult.swift
//  PresentationKit
//
//  Created by 신의연 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation
import ComposableArchitecture
import DomainKit

public struct SearchResultList: Reducer {
    public struct State: Equatable {
        var contentsList: [PreviewContentsModel]
        
        public init(
            contentsList: [PreviewContentsModel]
        ) {
            self.contentsList = contentsList
        }
    }
    
    public enum Action {
        case cellTapped
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .cellTapped:
                return .none
            }
        }
    }
}
