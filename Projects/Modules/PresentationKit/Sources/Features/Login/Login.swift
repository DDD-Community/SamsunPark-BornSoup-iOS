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
    public init() {}
    
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
                print(token)
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
    
    private func loginWithSnsToken(_ token: String, snsType: SNSType) -> Effect<Login.Action> {
        return .run { send async in
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 10
            configuration.timeoutIntervalForResource = 10
            let session =  Session(configuration: configuration)
            
            guard let response: LoginResponseModel = try? await session.request(
                "https://oneul.store/api/auth/signin",
                method: .post,
                parameters: [
                    "socialToken": token,
                    "socialType": snsType.rawValue
                ],
                encoder: JSONParameterEncoder.default,
                headers: ["Content-Type": "application/json"]
            ).serializingDecodable().value else {
                return
            }
            await send(.loginSuccess(response.body?.accessToken ?? ""))
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
