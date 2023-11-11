//
//  OnboardingNicknameView.swift
//  PresentationKit
//
//  Created by 고병학 on 10/1/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

public struct OnboardingNicknameView: View {
    
    public init(store: StoreOf<OnboardingNickname>) {
        self.store = store
    }
    
    let store: StoreOf<OnboardingNickname>
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                PaginationNavBar(
                    title: "회원가입",
                    numberOfPages: 4,
                    currentPage: 1,
                    isAccumulated: true,
                    backButtonAction: { viewStore.send(.didTapBackButton) }
                )
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("어떻게 불러드리면 될까요?")
                      .font(.Head1.semiBold)
                      .foregroundColor(Color.orangeGray1)
                      .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    OZTextField(
                        title: "닉네임을 입력해주세요.",
                        text: viewStore.$nickname,
                        invalidation: viewStore.$isNicknameInvalid
                    )
                    .padding(.top, 48)
                    
                    if viewStore.isNicknameInvalid {
                        Text("8자 이내로 작성해주세요")
                            .font(.Body1.regular)
                            .foregroundColor(Color.red)
                            .padding(.top, 10)
                    } else if viewStore.isNicknameDuplicated {
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
                    state: \.$onboardingInterestedPlace,
                    action: OnboardingNickname.Action.onboardingInterestedPlace
                )
            ) {
                OnboardingInterestedPlaceView(store: $0)
            }
        }
    }
}

#if DEBUG
struct OnboardingNicknameView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingNicknameView(store: .init(initialState: OnboardingNickname.State()) {
            OnboardingNickname()
        })
    }
}
#endif
