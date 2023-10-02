//
//  LoginView.swift
//  PresentationKit
//
//  Created by 고병학 on 9/30/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

fileprivate enum Constants {
    enum Sizes {
        static let logoWidth: CGFloat = 90.0
        static let logoHeight: CGFloat = 90.0
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
        static let appName: String = "오 · 전"
        static let appSubtitle: String = "오늘을 전통문화로 채우다"
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
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                VStack(spacing: 0) {
                    VStack {
                        Spacer()
                        Image.DK.icOzeonLogo.swiftUIImage
                            .resizable()
                            .frame(
                                width: Constants.Sizes.logoWidth,
                                height: Constants.Sizes.logoHeight
                            )
                            .padding(.bottom, Constants.Sizes.bottomPaddingOfLogo)
                        Text(Constants.Strings.appName)
                            .font(Font.Head1.semiBold)
                            .padding(.bottom, Constants.Sizes.textBottomPadding)
                        Text(Constants.Strings.appSubtitle)
                            .font(Font.Body1.regular)
                            .foregroundStyle(Color.orangeGray5)
                        Spacer()
                    }
                    
                    SNSLoginButton(snsType: .KAKAO) {
                        viewStore.send(.didTapKakaoLoginButton)
                    }
                    .padding(.horizontal, Constants.Sizes.containerHorizontalPadding)
                    .padding(.bottom, Constants.Sizes.loginButtonBottomPadding)
                    
                    SNSLoginButton(snsType: .APPLE) {
                        viewStore.send(.didTapAppleLoginButton)
                    }
                    .padding(.horizontal, Constants.Sizes.containerHorizontalPadding)
                    .padding(.bottom, Constants.Sizes.loginButtonBottomPadding)
                    
                    Button(action: {
                        viewStore.send(.didTapLookAround)
                    }, label: {
                        Text(Constants.Strings.lookAround)
                            .font(.Title2.regular)
                            .foregroundStyle(Color.orangeGray5)
                    })
                    .padding(.vertical, Constants.Sizes.loginButtonBottomPadding)
                }
                .navigationBarBackButtonHidden()
                .sheet(store: store.scope(
                    state: \.$privacyPolicy,
                    action: Login.Action.privacyPolicy
                )) {
                    PrivacyPolicyView(store: $0)
                }
                .navigationDestination(
                    store: store.scope(
                        state: \.$onboardingNickname,
                        action: Login.Action.onboardingNickname
                    )) {
                        OnboardingNicknameView(store: $0)
                    }
            }
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
