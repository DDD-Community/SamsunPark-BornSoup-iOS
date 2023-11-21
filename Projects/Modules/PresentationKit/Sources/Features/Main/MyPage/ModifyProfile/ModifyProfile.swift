//
//  ModifyProfile.swift
//  PresentationKit
//
//  Created by 고병학 on 11/19/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import DomainKit
import KeychainAccess

public struct ModifyProfile: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init(userInfo: MyPageInfoBody) {
            self.userInfo = userInfo
        }
        
        var userInfo: MyPageInfoBody
        
        var showLogoutPopup: Bool = false
    }
    
    public enum Action: Equatable {
        case didTapBackButton
        case didTapLogout
        case didTapConfirmLogout
        case didTapCancelLogout
        case didTapResign
        
        case resignCompleted
    }
    
    @Dependency(\.authUseCase) var authUseCase
    @Dependency(\.dismiss) var dismiss
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapBackButton:
                return .run { _ async in
                    await self.dismiss()
                }
                
            case .didTapLogout:
                state.showLogoutPopup = true
                return .none
                
            case .didTapConfirmLogout:
                try? Keychain().removeAll()
                return .run { _ async in
                    await self.dismiss()
                }
                
            case .didTapCancelLogout:
                state.showLogoutPopup = false
                return .none
                
            case .resignCompleted:
                return .run { _ async in
                    await self.dismiss()
                }
                
            default:
                return .none
            }
        }
    }
}
