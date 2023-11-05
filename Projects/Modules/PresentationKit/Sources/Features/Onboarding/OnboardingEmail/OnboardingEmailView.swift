//
//  OnboardingEmailView.swift
//  PresentationKit
//
//  Created by 고병학 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

public struct OnboardingEmailView: View {
    
    public init(store: StoreOf<OnboardingEmail>) {
        self.store = store
    }
    
    let store: StoreOf<OnboardingEmail>
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                PaginationNavBar(
                    title: "회원가입",
                    numberOfPages: 4,
                    currentPage: 0,
                    isAccumulated: true,
                    backButtonAction: { viewStore.send(.didTapBackButton) }
                )
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("이메일을 입력해주세요")
                      .font(.Head1.semiBold)
                      .foregroundColor(Color.orangeGray1)
                      .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    OZTextField(
                        title: "ozeon.example.com",
                        text: viewStore.$email,
                        invalidation: viewStore.$isEmailInvalid
                    )
                    .modifier(EmailKeyboardModifier())
                    .padding(.top, 48)
                    
                    if viewStore.isEmailInvalid {
                        Text("이메일 형식이 아닙니다")
                            .font(.Body1.regular)
                            .foregroundColor(Color.red)
                            .padding(.top, 10)
                    } else if viewStore.isEmailDuplicated {
                        Text("다른 사람이 사용중입니다")
                            .font(.Body1.regular)
                            .foregroundColor(Color.red)
                            .padding(.top, 10)
                    }
                    
                    Spacer()
                    
                    PrimaryButton(
                        title: "다음",
                        isActivated: viewStore.state.isNextButtonActivated
                    ) {
                        viewStore.send(.didTapConfirmButton)
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationBarBackButtonHidden()
            .navigationDestination(
                store: store.scope(
                    state: \.$onboardingNickname,
                    action: OnboardingEmail.Action.onboardingNickname
                )
            ) {
                OnboardingNicknameView(store: $0)
            }
        }
    }
}

#if DEBUG
struct OnboardingEmailView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingEmailView(store: .init(initialState: OnboardingEmail.State()) {
            OnboardingEmail()
        })
    }
}
#endif
