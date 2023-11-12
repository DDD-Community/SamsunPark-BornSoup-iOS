//
//  OnboardingComplete.swift
//  PresentationKit
//
//  Created by 고병학 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

public struct OnboardingComplete: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init(username: String) {
            self.username = username
        }
        
        let username: String
    }
    
    public enum Action {
        case didTapConfirmButton
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            case .didTapConfirmButton:
                return .none
            }
        }
    }
}
