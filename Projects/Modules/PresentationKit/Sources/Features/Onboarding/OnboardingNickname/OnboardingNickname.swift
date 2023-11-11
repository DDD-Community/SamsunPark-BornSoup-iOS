//
//  OnboardingNickname.swift
//  PresentationKit
//
//  Created by 고병학 on 10/1/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import CoreKit

import Foundation

public struct OnboardingNickname: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
        
        @BindingState var nickname: String = ""
        @BindingState var isNicknameInvalid: Bool = false
        @BindingState var isNicknameDuplicated: Bool = false
        
        var isNextButtonActivated: Bool = false
        
        @PresentationState var onboardingInterestedPlace: OnboardingInterestedPlace.State?
    }
    
    public enum Action: BindableAction {
        case didTapBackButton
        case didTapConfirmButton
        case binding(BindingAction<State>)

        case checkNickname(String)
        case setDuplicatedNicknameInfoMessage(Bool)
        case setNextButtonActivated(Bool)
        
        case onboardingInterestedPlace(PresentationAction<OnboardingInterestedPlace.Action>)
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.authUseCase) var authUseCase
    @Dependency(\.mainQueue) var mainQueue
    
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
                return .send(.checkNickname(state.nickname))
                    .debounce(id: "debounce_textfield", for: 0.5, scheduler: mainQueue)
                
            case .binding:
                return .none
                
            case .setNextButtonActivated(let isActivated):
                state.isNextButtonActivated = isActivated
                return .none
                
            case .setDuplicatedNicknameInfoMessage(let isDuplicated):
                state.isNicknameDuplicated = isDuplicated
                return .none
                
            case .checkNickname(let nickname):
                let isValid: Bool = !state.isNicknameInvalid
                return .run { send async in
                    let (isDuplicatedNickname, error): (Bool, Error?) = await authUseCase.isDuplicatedNickname(nickname)
                    if let error {
                        Logger.log(error.localizedDescription, "\(Self.self)", #function)
                    }
                    await send(.setDuplicatedNicknameInfoMessage(isDuplicatedNickname))
                    await send(.setNextButtonActivated(!isDuplicatedNickname && isValid))
                }
                
            case .didTapConfirmButton:
                state.onboardingInterestedPlace = .init()
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(\.$onboardingInterestedPlace, action: /Action.onboardingInterestedPlace) {
            OnboardingInterestedPlace()
        }
    }
}
