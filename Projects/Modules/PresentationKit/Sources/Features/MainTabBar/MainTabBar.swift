//
//  MainTabBar.swift
//  PresentationKit
//
//  Created by 고병학 on 10/1/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import Foundation

public struct MainTabBar: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
        
        var homeState: Home.State = Home.State(
            curating: Curating.State(contentsList: []),
            allContents: AllContents.State(contentsList: []),
            allContentsFilter: AllContentsFilter.State(filterList: [])
        )
        
        var myPage: MyPage.State = .init()
    }
    
    public enum Action {
        case home(Home.Action)
        case myPage(MyPage.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            default:
                return .none
            }
        }
        Scope(state: \.homeState, action: /Action.home) {
            Home()
        }
        Scope(state: \.myPage, action: /Action.myPage) {
            MyPage()
        }
    }
}
