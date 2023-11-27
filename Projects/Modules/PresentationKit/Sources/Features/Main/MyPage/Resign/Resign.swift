//
//  Resign.swift
//  PresentationKit
//
//  Created by 고병학 on 11/20/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import KeychainAccess

import Foundation

public struct Resign: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
    
        var showResignPopup: Bool = false
        
        var serviceResignCompleted: Bool = false
        var appleResignCompleted: Bool = false
    }
    
    public enum Action: Equatable {
        case didTapBackButton
        case didTapResignButton
        case didCompletedServiceResigning
        case didCompletedAppleResigning
        case didCompletedResigning
        case didTapConfirmResign
        case didTapCancelResign
    }
    
    @Dependency(\.authUseCase) var authUseCase
    @Dependency(\.dismiss) var dismiss
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapBackButton:
                return .run { _ async in
                    await dismiss()
                }
                
            case .didTapResignButton:
                state.showResignPopup = true
                return .none
                
            case .didTapConfirmResign:
                return .run { send async in
                    let (response, error) = await authUseCase.resign()
                    guard let response else {
                        await send(.didTapBackButton)
                        print(error ?? "authUseCase.resign() error")
                        return
                    }
                    print(response)
                    try? Keychain().removeAll()
                    await send(.didCompletedServiceResigning)
                }
                
            case .didCompletedServiceResigning:
                state.serviceResignCompleted = true
                if state.appleResignCompleted {
                    return .send(.didCompletedResigning)
                }
                return .none
                
            case .didCompletedAppleResigning:
                state.appleResignCompleted = true
                if state.serviceResignCompleted {
                    return .send(.didCompletedResigning)
                }
                return .none
                
            case .didTapCancelResign:
                state.showResignPopup = false
                return .none
                
            default:
                return .none
            }
        }
    }
}
