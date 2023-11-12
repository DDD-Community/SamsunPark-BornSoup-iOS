//
//  WirteHistory.swift
//  PresentationKit
//
//  Created by 고병학 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

public struct WriteHistory: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action: Equatable {
        case didTapConfirmButton
        case didTapBackButton
    }
    
    @Dependency(\.dismiss) var dismiss
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapConfirmButton:
                return .none
                
            case .didTapBackButton:
                return .run { _ async in
                    await self.dismiss()
                }
            }
        }
    }
}
