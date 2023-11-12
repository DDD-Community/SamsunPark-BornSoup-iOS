//
//  OnboardingInterestedContentsView.swift
//  PresentationKit
//
//  Created by 고병학 on 11/11/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

public struct OnboardingInterestedContentsView: View {
    public init(store: StoreOf<OnboardingInterestedContents>) {
        self.store = store
    }
    
    let store: StoreOf<OnboardingInterestedContents>
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                PaginationNavBar(
                    title: "회원가입",
                    numberOfPages: 4,
                    currentPage: 3,
                    isAccumulated: true,
                    backButtonAction: { viewStore.send(.didTapBackButton) }
                )
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("관심 있는 전통 콘텐츠\n최대 3개 알려주세요! ")
                      .font(.Head1.semiBold)
                      .foregroundColor(Color.orangeGray1)
                      .frame(maxWidth: .infinity, alignment: .topLeading)
                      .padding(.bottom, 30)
                    
                    ScrollView(showsIndicators: false) {
                        WrappingHStack(
                            models: Array(viewStore.state.initialContents.indices),
                            viewGenerator: { index in
                                CategoryCardButton(
                                    title: viewStore.state.initialContents[safe: index]?.name ?? "",
                                    image: viewStore.state.initialContents[safe: index]?.image,
                                    isSelected: viewStore.state.selectedContents.contains(index)) {
                                        viewStore.send(.selectContent(index))
                                    }
                            },
                            horizontalSpacing: 8,
                            verticalSpacing: 12
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
struct OnboardingInterestedContentsView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingInterestedContentsView(store: .init(
            initialState: OnboardingInterestedContents.State(),
            reducer: {
                OnboardingInterestedContents()
            })
        )
    }
}
#endif
