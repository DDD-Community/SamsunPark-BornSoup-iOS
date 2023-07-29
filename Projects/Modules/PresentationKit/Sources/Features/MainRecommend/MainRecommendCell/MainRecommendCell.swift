//
//  MainRecommendCell.swift
//  PresentationKit
//
//  Created by 고병학 on 2023/07/29.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import DomainKit

import Foundation

public struct MainRecommendCell: ReducerProtocol {
    public struct State: Equatable {
        var recommendation: EventRecommendation
    }
    
    public enum Action: Equatable {
        case onAppear
    }
    
    public func reduce(
        into state: inout State,
        action: Action
    ) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            return .none
        }
    }
}
