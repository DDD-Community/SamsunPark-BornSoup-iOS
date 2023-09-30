//
//  Onboarding.swift
//  PresentationKit
//
//  Created by 고병학 on 9/30/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import Foundation

public struct Onboarding: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
        
        @PresentationState var login: Login.State?
        
        var contentStep: Int = 0
        var contents: [String] = [
            "전통문화콘텐츠 정보에 특화",
            "나만의 전통문화큐레이터",
            "온전히 공간에 대한 정보"
        ]
        var subContents: [String] = [
            "더 이상 헤매지 않아도 괜찮아요\n오전에는 모든 전통문화콘텐츠 정보가 있어요!",
            "기록할수록 내 취향에 딱 맞게\n전통문화콘텐츠 큐레이팅 할 수 있어요!",
            "포스터뿐만 아니라\n공간에 대한 실제 사진을 보여드릴게요!"
        ]
    }
    
    public enum Action {
        case pressNextStep
        case presentLogin
        case switchToMainTabBar
        
        case login(PresentationAction<Login.Action>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .pressNextStep:
                if state.contentStep < 2 {
                    state.contentStep += 1
                } else if state.contentStep == 2 {
                    return .send(.presentLogin)
                }
                return .none
                
            case .presentLogin:
                state.login = .init()
                return .none
                
            case .login(.dismiss):
                return .send(.switchToMainTabBar)
                
            default:
                return .none
            }
        }
        .ifLet(\.$login, action: /Action.login) {
            Login()
        }
    }
}
