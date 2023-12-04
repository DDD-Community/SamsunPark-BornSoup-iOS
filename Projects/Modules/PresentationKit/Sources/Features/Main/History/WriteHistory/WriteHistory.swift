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
        
        var isNextButtonActivated: Bool = false
        
        @BindingState var reviewText: String = ""
        @BindingState var isReviewPublic: Bool = false
    }
    
    public enum Action: BindableAction, Equatable {
        case _didTapConfirmButton
        case didTapConfirmButton
        case didTapBackButton
        
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.dismiss) var dismiss
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case ._didTapConfirmButton:
                return .none
                
            case .didTapConfirmButton:
                return .none
                
            case .didTapBackButton:
                return .run { _ async in
                    await self.dismiss()
                }
                
            case .binding:
                return .none
            }
        }
    }
}
