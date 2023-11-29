//
//  Curating.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/09/30.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import DomainKit
import Foundation

public struct Curating: Reducer {
    public struct State: Equatable {
        var contentsList: [PreviewContentsModel] = []
        
        public init(contentsList: [PreviewContentsModel] = []) {
            self.contentsList = contentsList
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        case contentsTapped(PreviewContentsModel)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            case .contentsTapped:
                return .none
            }
        }
    }
}

extension Curating.State {
    
}
