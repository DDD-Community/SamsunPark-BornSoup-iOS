//
//  MyPage.swift
//  PresentationKit
//
//  Created by 고병학 on 11/19/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import DomainKit

public struct MyPage: Reducer {

    public init() {}
    
    public struct State: Equatable {
        public init() {}
        
        var userInfo: MyPageInfoBody?
        var isSignedIn: Bool = false
        
        var path: StackState<Path.State> = .init()
    }
    
    public enum Action: Equatable {
        case path(StackAction<Path.State, Path.Action>)
        
        case onAppear
        case failedToFetchUserInfo
        
        case didTapModifyProfileButton
        
        case setUserInfo(MyPageInfoBody)
    }
    
    public struct Path: Reducer {
        public enum State: Equatable {
            case modifyProfile(ModifyProfile.State)
        }
        
        public enum Action: Equatable {
            case modifyProfile(ModifyProfile.Action)
        }
        
        public var body: some ReducerOf<Self> {
            Scope(state: /State.modifyProfile, action: /Action.modifyProfile) {
                ModifyProfile()
            }
        }
    }
    
    @Dependency(\.myPageUseCase) var myPageUseCase
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send async in
                    let (body, error) = await myPageUseCase.fetchMyInfo()
                    guard let body else {
                        print(error ?? "myPageUseCase.fetchMyInfo() error")
                        await send(.failedToFetchUserInfo)
                        return
                    }
                    await send(.setUserInfo(body))
                }
                
            case .failedToFetchUserInfo:
                state.isSignedIn = false
                return .none
                
            case .setUserInfo(let userInfo):
                state.userInfo = userInfo
                state.isSignedIn = true
                return .none
                
            case .didTapModifyProfileButton:
                if let userInfo = state.userInfo {
                    state.path.append(.modifyProfile(.init(userInfo: userInfo)))
                }
                return .none
                
            case .path(.element(id: _, action: .modifyProfile(.resignCompleted))):
                state.isSignedIn = false
                return .none
                
            default:
                return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
