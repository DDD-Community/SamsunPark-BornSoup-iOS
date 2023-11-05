//
//  PrivacyPolicy.swift
//  PresentationKit
//
//  Created by 고병학 on 10/1/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import Foundation

public struct PrivacyPolicy: Reducer {
    public struct State: Equatable {
        public init() {}
        
        var isAllAgreed: Bool = false
        var isServicePolicyAgreed: Bool = false
        var isPrivacyPolicyAgreed: Bool = false
        var isConfirmButtonActivated: Bool = false
        
        @PresentationState var ozWeb: OZWeb.State?
        @PresentationState var onboardingEmail: OnboardingEmail.State?
    }
    
    public enum Action {
        case didTapAgreeAllPolicy
        case didTapAgreeServicePolicy
        case didTapAgreePrivacyPolicy
        
        case didTapServicePolicyDetail
        case didTapPrivacyPolicyDetail
        
        case didTapBackButton
        case didTapConfirmButton
        
        case ozWeb(PresentationAction<OZWeb.Action>)
        case onboardingEmail(PresentationAction<OnboardingEmail.Action>)
    }
    
    @Dependency(\.dismiss) var dismiss
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapAgreeAllPolicy:
                state.isAllAgreed.toggle()
                state.isServicePolicyAgreed = state.isAllAgreed
                state.isPrivacyPolicyAgreed = state.isAllAgreed
                state.isConfirmButtonActivated = state.isAllAgreed
                return .none
                
            case .didTapAgreePrivacyPolicy:
                state.isPrivacyPolicyAgreed.toggle()
                state.isAllAgreed = state.isPrivacyPolicyAgreed && state.isServicePolicyAgreed
                state.isConfirmButtonActivated = state.isAllAgreed
                return .none
                
            case .didTapAgreeServicePolicy:
                state.isServicePolicyAgreed.toggle()
                state.isAllAgreed = state.isPrivacyPolicyAgreed && state.isServicePolicyAgreed
                state.isConfirmButtonActivated = state.isAllAgreed
                return .none
            
            case .didTapServicePolicyDetail:
                state.ozWeb = .init()
                return .none
            case .didTapPrivacyPolicyDetail:
                return .none
                
            case .didTapBackButton:
                return .run { _ in
                    await self.dismiss()
                }
                
            case .didTapConfirmButton:
                state.onboardingEmail = .init()
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(\.$ozWeb, action: /Action.ozWeb) {
            OZWeb()
        }
        .ifLet(\.$onboardingEmail, action: /Action.onboardingEmail) {
            OnboardingEmail()
        }
    }
}
