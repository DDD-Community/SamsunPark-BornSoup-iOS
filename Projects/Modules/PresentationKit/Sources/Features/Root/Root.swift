//
//  Root.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/07/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public enum SignInStatus: Equatable {
    case signed
    case unsigned
}

public struct Root: ReducerProtocol {
    
    public init() { }
    
    public struct State: Equatable {
        var selectedTab = TabbarMenu.main
        var main = Main.State()
        var signIn = SignIn.State()
        var signInStatus: SignInStatus = .unsigned
        
        public init() { }
    }
    
    public enum Action: Equatable {
        case tabSelected(TabbarMenu)
        case changeToMainView(SignInStatus)
        case onAppear
        
        case mainAction(Main.Action)
        case signInAction(SignIn.Action)
    }
    
    struct Environment { }
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("root onAppear")
                state = .init()
                return .none
            case .changeToMainView(let signInStatus):
                state.signInStatus = signInStatus
                return .none
            default:
                return .none
            }
        }
        Scope(state: \.main, action: /Action.mainAction) {
            Main()
        }
        Scope(state: \.signIn, action: /Action.signInAction) {
            SignIn()
        }
    }
    
}
