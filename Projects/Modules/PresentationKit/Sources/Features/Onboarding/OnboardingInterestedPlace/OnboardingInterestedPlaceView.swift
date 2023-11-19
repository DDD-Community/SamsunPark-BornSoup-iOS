//
//  OnboardingInterestedPlaceView.swift
//  PresentationKit
//
//  Created by 고병학 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

public struct OnboardingInterestedPlaceView: View {
    public init(store: StoreOf<OnboardingInterestedPlace>) {
        self.store = store
    }
    
    let store: StoreOf<OnboardingInterestedPlace>
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                PaginationNavBar(
                    title: "회원가입",
                    numberOfPages: 4,
                    currentPage: 2,
                    isAccumulated: true,
                    backButtonAction: { viewStore.send(.didTapBackButton) }
                )
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("관심 있는 지역에서\n전통 콘텐츠를 찾아드릴게요!")
                      .font(.Head1.semiBold)
                      .foregroundColor(Color.orangeGray1)
                      .frame(maxWidth: .infinity, alignment: .topLeading)
                      .padding(.bottom, 8)
                    
                    Text("현재는 서울 안에 정보만 제공하고 있어요.")
                        .font(.Title2.regular)
                        .foregroundColor(.orangeGray3)
                        .padding(.bottom, 48)
                    
                    ScrollView(showsIndicators: false) {
                        WrappingHStack(
                            models: Array(viewStore.state.initialPlaces.indices),
                            viewGenerator: { index in
                                ChipButton(
                                    text: viewStore.state.initialPlaces[safe: index] ?? "",
                                    isSelected: viewStore.state.selectedPlaceIndices.contains(index)
                                )
                                .onTapGesture {
                                    viewStore.send(.selectPlace(index))
                                }
                            },
                            horizontalSpacing: 6,
                            verticalSpacing: 9
                        )
                    }
                    
                    Spacer()
                    
                    PrimaryButton(
                        title: "다음",
                        isActivated: viewStore.state.isNextButtonActivated
                    ) {
                        viewStore.send(._didTapConfirmButton)
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
            .navigationBarBackButtonHidden()
        }
    }
}

#if DEBUG
struct OnboardingInterestedPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingInterestedPlaceView(store: .init(
            initialState: OnboardingInterestedPlace.State(
                email: "email",
                nickname: "nickname"
            )
        ) {
            OnboardingInterestedPlace()
        })
    }
}
#endif
