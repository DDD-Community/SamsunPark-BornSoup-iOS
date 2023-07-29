//
//  TermAgreement.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/07/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

public struct TermAgreement: ReducerProtocol {
    public struct State: Equatable {
        var sample = ""
        
        public init() { }
    }
    
    public enum Action: Equatable {
        case sample
    }
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .sample:
            return .none
        }
    }
}
