//
//  LoginView.swift
//  PresentationKit
//
//  Created by 고병학 on 9/30/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import AuthenticationServices
import ComposableArchitecture
import KakaoSDKAuth
import KakaoSDKCommon
import KeychainAccess

import SwiftUI

fileprivate enum Constants {
    enum Sizes {
        static let logoWidth: CGFloat = 58.0
        static let logoHeight: CGFloat = 58.0
        static let snsLoginLogoSize: CGFloat = 18.0
        static let snsLoginHorizontalSpace: CGFloat = 10.0
        static let bottomPaddingOfLogo: CGFloat = 16.0
        static let textBottomPadding: CGFloat = 12.0
        static let signInLabelVerticalPadding: CGFloat = 16.0
        static let containerHorizontalPadding: CGFloat = 16.0
        static let loginButtonBottomPadding: CGFloat = 8.0
        static let buttonCornerRadius: CGFloat = 100.0
    }
    enum Colors {
        static let kakaoYellow: Color = Color(red: 1, green: 0.9, blue: 0)
        
    }
    enum Strings {
        static let appSubtitle: String = "오롯이 전하는 \n전통문화 큐레이션"
        static let kakaoLogin: String = "카카오로 로그인"
        static let appleLogin: String = "Apple로 로그인"
        static let lookAround: String = "둘러보기"
    }
}

public struct LoginView: View {
    
    let store: StoreOf<Login>
    
    public init(store: StoreOf<Login>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(
            self.store.scope(state: \.path, action: { .path($0) })
        ) {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                ZStack {
                    VStack(spacing: 0) {
                        VStack {
                            Spacer()
                            HStack(alignment: .center, spacing: 4.45265) {
                                Image.DK.icOzeonLogo.swiftUIImage
                                    .resizable()
                                    .frame(
                                        width: Constants.Sizes.logoWidth,
                                        height: Constants.Sizes.logoHeight
                                    )
                                    .padding(.bottom, Constants.Sizes.bottomPaddingOfLogo)
                                DesignSystemKitAsset.ojeonTitleLogo.swiftUIImage
                                    .scaledToFill()
                                    .frame(width: 110, height: 58)
                                    .padding(.bottom, Constants.Sizes.textBottomPadding)
                            }
                            Text(Constants.Strings.appSubtitle)
                                .font(Font.Head2.semiBold)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.orangeGray3)
                            Spacer()
                        }
                        
//                        SNSLoginButton(snsType: .KAKAO) {
//                            viewStore.send(.didTapKakaoLoginButton)
//                        }
//                        .padding(.horizontal, Constants.Sizes.containerHorizontalPadding)
//                        .padding(.bottom, Constants.Sizes.loginButtonBottomPadding)
                        
                        SignInWithAppleButton(.continue) { request in
                            request.requestedScopes = [.fullName, .email]
                        } onCompletion: { result in
                            self.handleAppleLoginResult(result: result) { (identityToken: String) in
                                viewStore.send(.successAppleLogin(identityToken, ""))
                            }
                        }
                        .frame(height: 50)
                        .padding(.horizontal, Constants.Sizes.containerHorizontalPadding)
                        .padding(.bottom, Constants.Sizes.loginButtonBottomPadding)
                        
                        Button(action: {
                            viewStore.send(
                                .didTapLookAround,
                                animation: .easeOut(duration: 0.2)
                            )
                        }, label: {
                            Text(Constants.Strings.lookAround)
                                .font(.Title2.regular)
                                .foregroundStyle(Color.orangeGray5)
                        })
                        .padding(.vertical, Constants.Sizes.loginButtonBottomPadding)
                    }
                    .background(.white)
                    .navigationBarBackButtonHidden()
                    
                    OZDialogView(
                        title: "회원가입하면\n나에게 맞춘 전통 콘텐츠를 만날 수 있어요!\n회원가입 하시겠어요?",
                        cancelString: "둘러볼게요",
                        confirmString: "가입할게요"
                    ) {
                        viewStore.send(.didTapDialogContinueButton)
                    } confirmAction: {
                        viewStore.send(.didTapDialogSignUpButton)
                    }
                    .opacity(viewStore.state.isSignUpDialogPresented ? 1 : 0)
                    .ignoresSafeArea()
                }
            }
        } destination: { (state: Login.Path.State) in
            switch state {
            case .privacyPolicy:
                CaseLet(
                    /Login.Path.State.privacyPolicy,
                     action: Login.Path.Action.privacyPolicy,
                     then: PrivacyPolicyView.init(store:)
                )
            case .onboardingEmail:
                CaseLet(
                    /Login.Path.State.onboardingEmail,
                     action: Login.Path.Action.onboardingEmail,
                     then: OnboardingEmailView.init(store:)
                )
            case .onboardingNickname:
                CaseLet(
                    /Login.Path.State.onboardingNickname,
                     action: Login.Path.Action.onboardingNickname,
                     then: OnboardingNicknameView.init(store:)
                )
            case .onboardingInterestedPlace:
                CaseLet(
                    /Login.Path.State.onboardingInterestedPlace,
                     action: Login.Path.Action.onboardingInterestedPlace,
                     then: OnboardingInterestedPlaceView.init(store:)
                )
            case .onboardingInterestedContents:
                CaseLet(
                    /Login.Path.State.onboardingInterestedContents,
                     action: Login.Path.Action.onboardingInterestedContents,
                     then: OnboardingInterestedContentsView.init(store:)
                )
            case .onboardingComplete:
                CaseLet(
                    /Login.Path.State.onboardingComplete,
                     action: Login.Path.Action.onboardingComplete,
                     then: OnboardingCompleteView.init(store:)
                )
            case .ozWeb:
                CaseLet(
                    /Login.Path.State.ozWeb,
                     action: Login.Path.Action.ozWeb,
                     then: OZWebView.init(store:)
                )
            }
        }
    }
    
    private func handleAppleLoginResult(
        result: Result<ASAuthorization, Error>,
        completion: @escaping (String) -> Void
    ) {
        switch result {
        case .success(let authResults):
            switch authResults.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                if let tokenData = appleIDCredential.identityToken,
                   let identityToken = String(data: tokenData, encoding: .utf8) {
                    try? Keychain().set(appleIDCredential.email ?? "", key: "EMAIL")
                    try? Keychain().set(appleIDCredential.fullName?.description ?? "", key: "NAME")
                    completion(identityToken)
                }
            default:
                break
            }
        case .failure(let error):
            Logger.log(error.localizedDescription, "\(Self.self)", #function)
        }
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(store: Store(initialState: Login.State()) {
            Login()
        })
    }
}
#endif
