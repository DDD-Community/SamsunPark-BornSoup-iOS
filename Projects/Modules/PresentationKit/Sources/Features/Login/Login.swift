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
        
        @BindingState var isSignUpDialogPresented: Bool = false
    
        @PresentationState var privacyPolicy: PrivacyPolicy.State?
    }
    
    public enum Action {
        case didTapKakaoLoginButton
        case didTapAppleLoginButton
        case didTapLookAround
        
        case didTapBackButton
        case didTapDialogContinueButton
        case didTapDialogSignUpButton
        
        case privacyPolicy(PresentationAction<PrivacyPolicy.Action>)
    }
    
    @Dependency(\.dismiss) var dismiss
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapKakaoLoginButton:
                print("didTapKakaoLoginButton")
                return .none
                
            case .didTapAppleLoginButton:
                print("didTapAppleLoginButton")
                return .none
                
            case .didTapLookAround:
                state.isSignUpDialogPresented = true
                return .none

            case .didTapDialogContinueButton:
                state.isSignUpDialogPresented = false
                return .run { _ async in
                    await self.dismiss()
                }
                
            case .didTapDialogSignUpButton:
                state.isSignUpDialogPresented = false
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(\.$privacyPolicy, action: /Action.privacyPolicy) {
            PrivacyPolicy()
        }
    }
}
