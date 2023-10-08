//
//  OnboardingNickname.swift
//  PresentationKit
//
//  Created by 고병학 on 10/1/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import Foundation

public struct OnboardingNickname: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
        
        @BindingState var nickname: String = ""
        @BindingState var isNicknameInvalid: Bool = false
        
        var isNextButtonActivated: Bool = false
    }
    
    public enum Action: BindableAction {
        case didTapBackButton
        case didTapConfirmButton
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.dismiss) var dismiss
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .didTapBackButton:
                return .run { _ in
                    await self.dismiss()
                }
                
            case .binding(\.$nickname):
                state.isNicknameInvalid = state.nickname.count > 8
                state.isNextButtonActivated = 1...8 ~= state.nickname.count
                return .none
                
            case .binding:
                return .none

            default:
                return .none
            }
        }
    }
}
