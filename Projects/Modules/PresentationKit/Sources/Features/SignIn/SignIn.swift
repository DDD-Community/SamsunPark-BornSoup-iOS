//
//  SignIn.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/07/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

public enum SocialSignInType: String, Codable, Equatable, Hashable {
    case kakao
    case apple
}

public struct SocialSignInUp: Identifiable {
    public var id: UUID
    var type: SocialSignInType
    var key: String? = ""
    
    init(type: SocialSignInType, key: String? = nil) {
        self.id = UUID()
        self.type = type
        self.key = key
    }
}

public struct SignIn: ReducerProtocol {
    
    public struct State: Equatable {
        var path = StackState<Path.State>()
        var signInType = SocialSignInType.kakao
    }
    
    public enum Action: Equatable {
        case path(StackAction<Path.State, Path.Action>)
        case signInButtonTapped(SocialSignInType)
    }
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .signInButtonTapped(let type):
                state.signInType = type
                // return .send 쇼셜 네트워크 작업
                return .none
            case .path(let action):
                switch action {
                case .element(id: _, action: .moveToTermAgreement):
                    state.path.append(.termAgreement())
                    return .none
                default:
                    return .none
                }
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
    
    public struct Path: ReducerProtocol {
        public enum State: Equatable {
            case termAgreement(TermAgreement.State = .init())
        }
        
        public enum Action: Equatable {
            case moveToTermAgreement(TermAgreement.Action)
        }
        
        public var body: some ReducerProtocol<State, Action> {
            Scope(state: /State.termAgreement, action: /Action.moveToTermAgreement) {
                TermAgreement()
            }
        }
    }
}
