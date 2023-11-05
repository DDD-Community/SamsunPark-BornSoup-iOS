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
import KeychainAccess

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
                return loginWithSocialToken(token, socialType: .KAKAO)
                
            case .successAppleLogin(let token):
                return loginWithSocialToken(token, socialType: .APPLE)
                
            case .loginSuccess(let token):
                try? Keychain().set(token, key: "ACCESS_TOKEN")
                state.privacyPolicy = .init()
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
    
    private func loginWithSocialToken(_ token: String, socialType: SocialType) -> Effect<Login.Action> {
        return .run { send async in
            let (token, error) = await authUseCase.loginWithSocialToken(token, socialType: socialType)
            guard let token, !token.isEmpty else {
                Logger.log(error.debugDescription, "\(Self.self)", #function)
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
                        Logger.log(error?.localizedDescription, "\(Login.self)", "requestKakaoTokenAsync")
                        continuation.resume(returning: nil)
                        return
                    }
                    continuation.resume(returning: accessToken)
                }
            } else {
                UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    guard let accessToken = oauthToken?.accessToken else {
                        Logger.log(error?.localizedDescription, "\(Login.self)", "requestKakaoTokenAsync")
                        continuation.resume(returning: nil)
                        return
                    }
                    continuation.resume(returning: accessToken)
                }
            }
        }
    }
}
