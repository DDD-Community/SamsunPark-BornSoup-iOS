//
//  OnboardingCompleteView.swift
//  PresentationKit
//
//  Created by 고병학 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

public struct OnboardingCompleteView: View {
    public init(store: StoreOf<OnboardingComplete>) {
        self.store = store
    }
    
    private let store: StoreOf<OnboardingComplete>
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                DesignSystemKitAsset.icCheck176.swiftUIImage
                    .frame(width: 176, height: 176)
                
                VStack(alignment: .leading) {
                    Text("회원가입이 완료되었어요!")
                        .font(.Head1.semiBold)
                        .foregroundColor(Color.orangeGray1)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.bottom, 12)
                        .padding(.top, 85)
                    
                    Text("오늘부터 \(viewStore.state.username)님의 취향에 맞춰\n전통문화콘텐츠를 큐레이팅 해드릴게요!")
                        .font(Font.Title2.regular)
                        .foregroundColor(Color.orangeGray4)
                    Spacer()
                    
                    PrimaryButton(title: "다음", isActivated: true) {
                        viewStore.send(.didTapConfirmButton)
                    }
                }
                .padding(.horizontal, 16)
                .onAppear {
                    UIScrollView.appearance().bounces = false
                }
                .onDisappear {
                    UIScrollView.appearance().bounces = true
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#if DEBUG
struct OnboardingCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCompleteView(
            store: .init(
                initialState: OnboardingComplete.State(username: "병학"),
                reducer: {
                    OnboardingComplete()
                }
            )
        )
    }
}
#endif
