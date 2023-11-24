//
//  MainTabBarView.swift
//  PresentationKit
//
//  Created by 고병학 on 10/1/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

public struct MainTabBarView: View {
    
    let store: StoreOf<MainTabBar>
    
    public init(store: StoreOf<MainTabBar>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            TabView {
                HomeView(store: self.store.scope(state: \.homeState, action: MainTabBar.Action.home))
                .tabItem {
                    DesignSystemKitAsset.icNaviHomeOn.swiftUIImage.renderingMode(.template)
                    Text("홈")
                }
                
//                Text("주변 탐색")
//                    .tabItem {
//                        DesignSystemKitAsset.icNaviLocationOn.swiftUIImage.renderingMode(.template)
//                        Text("주변 탐색")
//                    }
//                
//                HistoryRootView(store: .init(
//                    initialState: .init(),
//                    reducer: { HistoryRoot() }
//                ))
//                .tabItem {
//                    DesignSystemKitAsset.icNaviMyrecordOn.swiftUIImage.renderingMode(.template)
//                    Text("관람기록")
//                }
                
                MyPageView(store: self.store.scope(state: \.myPage, action: MainTabBar.Action.myPage))
                .tabItem {
                    DesignSystemKitAsset.icNaviMypageOn.swiftUIImage.renderingMode(.template)
                    Text("내 정보")
                }
            }
            .tint(.orangeGray1)
            .onAppear {
                UITabBar.appearance().unselectedItemTintColor = UIColor(Color.orangeGray5)
                UITabBar.appearance().backgroundColor = .white.withAlphaComponent(0.8)
                UITabBar.appearance().isTranslucent = true
            }
        }
    }
}

//#if DEBUG
//struct MainTabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabBarView(store: Store(initialState: MainTabBar.State()) {
//            MainTabBar()
//        })
//    }
//}
//
//#endif
