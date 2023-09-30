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
        Text("MainTabBar")
    }
}

#if DEBUG
struct MainTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView(store: Store(initialState: MainTabBar.State()) {
            MainTabBar()
        })
    }
}

#endif
