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
        
        var path: StackState<Path.State> = .init()
        
        @BindingState var isSignUpDialogPresented: Bool = false
    }
    
    public struct Path: Reducer {
        public enum State: Equatable {
            case privacyPolicy(PrivacyPolicy.State)
            case onboardingEmail(OnboardingEmail.State)
            case onboardingNickname(OnboardingNickname.State)
            case onboardingInterestedPlace(OnboardingInterestedPlace.State)
            case onboardingInterestedContents(OnboardingInterestedContents.State)
            case onboardingComplete(OnboardingComplete.State)
            case ozWeb(OZWeb.State)
        }
        
        public enum Action: Equatable {
            case privacyPolicy(PrivacyPolicy.Action)
            case onboardingEmail(OnboardingEmail.Action)
            case onboardingNickname(OnboardingNickname.Action)
            case onboardingInterestedPlace(OnboardingInterestedPlace.Action)
            case onboardingInterestedContents(OnboardingInterestedContents.Action)
            case onboardingComplete(OnboardingComplete.Action)
            case ozWeb(OZWeb.Action)
        }
        
        public var body: some ReducerOf<Self> {
            Scope(state: /State.privacyPolicy, action: /Action.privacyPolicy) {
                PrivacyPolicy()
            }
            Scope(state: /State.onboardingEmail, action: /Action.onboardingEmail) {
                OnboardingEmail()
            }
            Scope(state: /State.onboardingNickname, action: /Action.onboardingNickname) {
                OnboardingNickname()
            }
            Scope(state: /State.onboardingInterestedPlace, action: /Action.onboardingInterestedPlace) {
                OnboardingInterestedPlace()
            }
            Scope(state: /State.onboardingInterestedContents, action: /Action.onboardingInterestedContents) {
                OnboardingInterestedContents()
            }
            Scope(state: /State.onboardingComplete, action: /Action.onboardingComplete) {
                OnboardingComplete()
            }
            Scope(state: /State.ozWeb, action: /Action.ozWeb) {
                OZWeb()
            }
        }
    }
    
    public enum Action: Equatable {
        case path(StackAction<Path.State, Path.Action>)
        
        case didTapKakaoLoginButton
        case didTapLookAround
        
        case successAppleLogin(String, String)
        case successKakaoLogin(String, String)
        
        case loginSuccess(String, Bool)
        
        case didTapBackButton
        case didTapDialogContinueButton
        case didTapDialogSignUpButton
        case didCompleteSignup
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.authUseCase) var authUseCase
    
    public var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
            case .didTapKakaoLoginButton:
                return loginWithKakao()
                
            case let .successKakaoLogin(accessToken, idToken):
                return loginWithSocialToken(accessToken, idToken, socialType: .KAKAO)
                
            case let .successAppleLogin(accessToken, idToken):
                return loginWithSocialToken(accessToken, idToken, socialType: .APPLE)
                
            case let .loginSuccess(token, isSignUpNeeded):
                try? Keychain().set(token, key: "ACCESS_TOKEN")
                if !isSignUpNeeded {
                    return .send(.didCompleteSignup)
                } else {
                    state.path.append(.privacyPolicy(.init()))
                }
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
                
            case .path(.element(id: _, action: .privacyPolicy(.didTapConfirmButton))):
                let email: String = (try? Keychain().get("EMAIL")) ?? ""
                let nickname: String = (try? Keychain().get("NAME")) ?? ""
                state.path.append(.onboardingInterestedPlace(.init(email: email, nickname: nickname)))
                return .none
            case .path(.element(id: _, action: .privacyPolicy(.didTapPrivacyPolicyDetail))):
                state.path.append(.ozWeb(.init()))
                return .none
            case .path(.element(id: _, action: .privacyPolicy(.didTapServicePolicyDetail))):
                state.path.append(.ozWeb(.init()))
                return .none
                
//            case let .path(.element(id: _, action: .onboardingEmail(.didTapConfirmButton(email)))):
//                state.path.append(.onboardingNickname(.init(email: email)))
//                return .none
                
            case let .path(.element(id: _, action: .onboardingNickname(.didTapConfirmButton(email, nickname)))):
                state.path.append(.onboardingInterestedPlace(.init(email: email, nickname: nickname)))
                return .none
                
            case let .path(.element(id: _, action: .onboardingInterestedPlace(.didTapConfirmButton(
                email,
                nickname,
                places
            )))):
                state.path.append(.onboardingInterestedContents(.init(
                    email: email,
                    nickname: nickname,
                    places: places
                )))
                return .none
                
            case let .path(.element(id: _, action: .onboardingInterestedContents(.didTapConfirmButton(username)))):
                state.path.append(.onboardingComplete(.init(username: username)))
                return .none
                
            case .path(.element(id: _, action: .onboardingComplete(.didTapConfirmButton))):
                state.path.removeAll()
                return .send(.didCompleteSignup)
                
            default:
                return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
    
    private func loginWithSocialToken(
        _ accessToken: String,
        _ idToken: String,
        socialType: SocialType
    ) -> Effect<Login.Action> {
        return .run { send async in
            let (response, error) = await authUseCase.loginWithSocialToken(
                accessToken,
                idToken,
                socialType: socialType
            )
            guard let token = response?.accessToken, !token.isEmpty,
                  let isSignUpNeeded = response?.isSignUp else {
                Logger.log(error.debugDescription, "\(Self.self)", #function)
                return
            }
            await send(.loginSuccess(token, isSignUpNeeded))
        }
    }
    
    private func loginWithKakao() -> Effect<Login.Action> {
        return .run { send async in
            let (accessToken, idToken) = await requestKakaoTokenAsync()
            if let accessToken {
                await send(.successKakaoLogin(accessToken, idToken ?? ""))
            }
        }
    }
    
    @MainActor
    private func requestKakaoTokenAsync() async -> (String?, String?) {
        return await withCheckedContinuation { continuation in
            if UserApi.isKakaoTalkLoginAvailable() {
                UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                    guard let accessToken = oauthToken?.accessToken else {
                        Logger.log(error?.localizedDescription, "\(Login.self)", "requestKakaoTokenAsync")
                        continuation.resume(returning: (nil, nil))
                        return
                    }
                    continuation.resume(returning: (accessToken, oauthToken?.idToken))
                }
            } else {
                UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    guard let accessToken = oauthToken?.accessToken else {
                        Logger.log(error?.localizedDescription, "\(Login.self)", "requestKakaoTokenAsync")
                        continuation.resume(returning: (nil, nil))
                        return
                    }
                    continuation.resume(returning: (accessToken, oauthToken?.idToken))
                }
            }
        }
    }
}
