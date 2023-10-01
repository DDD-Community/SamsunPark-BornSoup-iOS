//
//  Login.swift
//  PresentationKit
//
//  Created by 고병학 on 9/30/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import Foundation

public struct Login: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
        
        @PresentationState var privacyPolicy: PrivacyPolicy.State?
    }
    
    public enum Action {
        case didTapKakaoLoginButton
        case didTapAppleLoginButton
        case didTapLookAround
        
        case privacyPolicy(PresentationAction<PrivacyPolicy.Action>)
    }
    
    @Dependency(\.dismiss) var dismiss
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapKakaoLoginButton:
                state.privacyPolicy = .init()
                return .none
                
            case .didTapLookAround:
                return .run { _ in
                    await self.dismiss()
                }

            default:
                return .none
            }
        }
        .ifLet(\.$privacyPolicy, action: /Action.privacyPolicy) {
            PrivacyPolicy()
        }
    }
}
