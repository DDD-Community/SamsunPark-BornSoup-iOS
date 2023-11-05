//
//  SplashView.swift
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
        static let bottomPaddingOfLogo: CGFloat = 16.0
        static let defaultYOffsetOfLogo: CGFloat = 500.0
        static let afterAnimationYOffsetOfLogo: CGFloat = 0
        static let textBottomPadding: CGFloat = 12.0
    }
    enum Strings {
        static let appName: String = "오 · 전"
        static let appSubtitle: String = "오늘을 전통문화로 채우다"
    }
}

public struct SplashView: View {
    
    let store: StoreOf<Splash>
    
    public init(store: StoreOf<Splash>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Image.DK.icOzeonLogo.swiftUIImage
                    .resizable()
                    .frame(
                        width: Constants.Sizes.logoWidth,
                        height: Constants.Sizes.logoHeight
                    )
                    .offset(
                        y: viewStore.isLogoHidden ?
                        Constants.Sizes.defaultYOffsetOfLogo
                        : Constants.Sizes.afterAnimationYOffsetOfLogo
                    )
                    .padding(.bottom, Constants.Sizes.bottomPaddingOfLogo)
                
                Text(Constants.Strings.appName)
                    .font(Font.Head1.semiBold)
                    .padding(.bottom, Constants.Sizes.textBottomPadding)
                    .opacity(viewStore.isTextHidden ? 0 : 1)
                
                Text(Constants.Strings.appSubtitle)
                    .font(Font.Body1.regular)
                    .foregroundStyle(Color.orangeGray5)
                    .opacity(viewStore.isTextHidden ? 0 : 1)
            }
            .onAppear {
                viewStore.send(
                    .appearLogoImage,
                    animation: .easeOut(duration: 1)
                )
            }
        }
    }
}

#if DEBUG
struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(
            store: Store(
                initialState: Splash.State()
            ) {
                Splash()
            }
        )
    }
}

#endif
