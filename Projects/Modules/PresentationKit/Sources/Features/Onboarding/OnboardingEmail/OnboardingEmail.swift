//
//  OnboardingEmail.swift
//  PresentationKit
//
//  Created by 고병학 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import CoreKit

import Foundation

public struct OnboardingEmail: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
        
        @BindingState var email: String = ""
        @BindingState var isEmailInvalid: Bool = false
        @BindingState var isEmailDuplicated: Bool = false
        
        var isNextButtonActivated: Bool = false
        
        @PresentationState var onboardingNickname: OnboardingNickname.State?
    }
    
    public enum Action: BindableAction {
        case didTapBackButton
        case didTapConfirmButton
        case binding(BindingAction<State>)

        case checkEmail(String)
        case setDuplicatedEmailInfoMessage(Bool)
        case setNextButtonActivated(Bool)
        
        case onboardingNickname(PresentationAction<OnboardingNickname.Action>)
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.authUseCase) var authUseCase
    @Dependency(\.mainQueue) var mainQueue
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onboardingNickname:
                return .none
                
            case .didTapBackButton:
                return .run { _ in
                    await self.dismiss()
                }
                
            case .didTapConfirmButton:
                state.onboardingNickname = .init()
                return .none
                
            case .binding(\.$email):
                guard !state.email.isEmpty else {
                    return .none
                }
                state.isEmailInvalid = !TextUtils.isValidEmail(email: state.email)
                return .send(.checkEmail(state.email))
                    .debounce(
                        id: "debounce_textfield",
                        for: 0.5,
                        scheduler: mainQueue
                    )
                
            case .binding:
                return .none
                
            case .setNextButtonActivated(let isActivated):
                state.isNextButtonActivated = isActivated
                return .none
                
            case .setDuplicatedEmailInfoMessage(let isDuplicated):
                state.isEmailDuplicated = isDuplicated
                return .none
                
            case .checkEmail(let email):
                let isValid: Bool = !state.isEmailInvalid
                return .run { send async in
                    let (isDuplicatedEmail, error): (Bool, Error?) = await authUseCase.isDuplicatedEmail(email)
                    if let error {
                        Logger.log(error.localizedDescription, "\(Self.self)", #function)
                    }
                    await send(.setDuplicatedEmailInfoMessage(isDuplicatedEmail))
                    await send(.setNextButtonActivated(!isDuplicatedEmail && isValid))
                }
            }
        }
        .ifLet(\.$onboardingNickname, action: /Action.onboardingNickname) {
            OnboardingNickname()
        }
    }
}
