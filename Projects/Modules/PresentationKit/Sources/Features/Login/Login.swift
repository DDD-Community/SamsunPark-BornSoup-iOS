//
//  Login.swift
//  PresentationKit
//
//  Created by 고병학 on 9/30/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Alamofire
import ComposableArchitecture
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

import Foundation

public struct Login: Reducer {
    
    public struct State: Equatable {
        public init() {}
        
        @BindingState var isSignUpDialogPresented: Bool = false
    
        @PresentationState var privacyPolicy: PrivacyPolicy.State?
    }
    
    public enum Action {
        case didTapKakaoLoginButton
        case didTapLookAround
        
        case successAppleLogin(String)
        case successKakaoLogin(String)
        
        case loginSuccess(String)
        
        case didTapBackButton
        case didTapDialogContinueButton
        case didTapDialogSignUpButton
        
        case privacyPolicy(PresentationAction<PrivacyPolicy.Action>)
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.authUseCase) var authUseCase
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapKakaoLoginButton:
                return loginWithKakao()
                
            case .successKakaoLogin(let token):
                return loginWithSnsToken(token, snsType: .KAKAO)
                
            case .successAppleLogin(let token):
                return loginWithSnsToken(token, snsType: .APPLE)
                
            case .loginSuccess(let token):
                print("🚧 token: \(token)")
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
    
    private func loginWithSnsToken(_ token: String, snsType: SocialType) -> Effect<Login.Action> {
        return .run { send async in
            let (token, error): (String?, Error?) = await authUseCase.loginWithSNSToken(token, socialType: snsType)
            guard let token, !token.isEmpty else {
                Logger.log(error.debugDescription)
                return
            }
            await send(.loginSuccess(token))
        }
    }
    
    private func loginWithKakao() -> Effect<Login.Action> {
        return .run { send async in
            if let accessToken: String = await requestKakaoTokenAsync() {
                await send(.successKakaoLogin(accessToken))
            }
        }
    }
    
    @MainActor
    private func requestKakaoTokenAsync() async -> String? {
        return await withCheckedContinuation { continuation in
            if UserApi.isKakaoTalkLoginAvailable() {
                UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                    guard let accessToken = oauthToken?.accessToken else {
                        Logger.log(error?.localizedDescription)
                        continuation.resume(returning: nil)
                        return
                    }
                    continuation.resume(returning: accessToken)
                }
            } else {
                UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    guard let accessToken = oauthToken?.accessToken else {
                        Logger.log(error?.localizedDescription)
                        continuation.resume(returning: nil)
                        return
                    }
                    continuation.resume(returning: accessToken)
                }
            }
        }
    }
}
