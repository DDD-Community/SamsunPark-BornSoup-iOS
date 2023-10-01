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
                    numberOfPages: 3,
                    currentPage: 0,
                    backButtonAction: { viewStore.send(.didTapBackButton) }
                )
                Spacer()
                Text("hello")
                Spacer()
                PrimaryButton(title: "다음", isActivated: false) {
                    viewStore.send(.didTapConfirmButton)
                }
                .padding(.horizontal, 16)
            }
            .navigationBarBackButtonHidden()
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
