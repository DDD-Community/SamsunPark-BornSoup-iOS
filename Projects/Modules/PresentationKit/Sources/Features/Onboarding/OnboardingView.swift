//
//  OnboardingView.swift
//  PresentationKit
//
//  Created by 고병학 on 9/30/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

fileprivate enum Constants {
    enum Sizes {
        static let imageVerticalPadding: CGFloat = 34
        static let indicatorBottomPadding: CGFloat = 32
        static let contentBottomPadding: CGFloat = 12
        static let nextButtonHorizontalPadding: CGFloat = 16
    }
    enum Strings {
        static let nextButtonTitle = "다음"
    }
}

public struct OnboardingView: View {
    
    let store: StoreOf<Onboarding>
    
    public init(store: StoreOf<Onboarding>) {
        self.store = store
    }
    
    private let onboardingImages: [Image] = [
        DesignSystemKitAsset.icOnboarding01.swiftUIImage,
        DesignSystemKitAsset.icOnboarding02.swiftUIImage,
        DesignSystemKitAsset.icOnboarding03.swiftUIImage
    ]
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 0) {
                    self.onboardingImages[viewStore.state.contentStep]
                        .foregroundColor(.clear)
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        .background(Color.white)
                        .padding(.vertical, Constants.Sizes.imageVerticalPadding)
                    
                    PageIndicator(
                        numberOfPages: viewStore.contents.count,
                        currentPage: viewStore.contentStep,
                        isAccumulated: false
                    )
                    .padding(.bottom, Constants.Sizes.indicatorBottomPadding)
                    
                    Text(viewStore.contents[safe: viewStore.contentStep] ?? "")
                        .font(.Head2.semiBold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.orangeGray1)
                        .padding(.bottom, Constants.Sizes.contentBottomPadding)
                    
                    Text(viewStore.subContents[safe: viewStore.contentStep] ?? "")
                        .font(.Body1.regular)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.orangeGray1)
                    
                    Spacer()
                    
                    PrimaryButton(
                        title: Constants.Strings.nextButtonTitle,
                        isActivated: true
                    ) {
                        viewStore.send(.pressNextStep)
                    }
                    .padding(.horizontal, Constants.Sizes.nextButtonHorizontalPadding)
                }
            }
            .fullScreenCover(
                store: store.scope(
                    state: \.$login,
                    action: Onboarding.Action.login
                ),
                content: {
                    LoginView(store: $0)
                }
            )
        }
    }
}

#if DEBUG
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(store: .init(initialState: Onboarding.State()) {
            Onboarding()
        })
    }
}
#endif
