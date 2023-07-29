//
//  MainRecommend.swift
//  PresentationKit
//
//  Created by 고병학 on 2023/07/29.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import DomainKit

import Foundation

public struct MainRecommend: ReducerProtocol {
    public struct State: Equatable {
        var eventRecommendations: [EventRecommendation] = [
            EventRecommendation(id: UUID(), title: "이벤트 1"),
            EventRecommendation(id: UUID(), title: "이벤트 2"),
            EventRecommendation(id: UUID(), title: "이벤트 3"),
            EventRecommendation(id: UUID(), title: "이벤트 4"),
            EventRecommendation(id: UUID(), title: "이벤트 5"),
            EventRecommendation(id: UUID(), title: "이벤트 6"),
            EventRecommendation(id: UUID(), title: "이벤트 7"),
            EventRecommendation(id: UUID(), title: "이벤트 8"),
            EventRecommendation(id: UUID(), title: "이벤트 9"),
            EventRecommendation(id: UUID(), title: "이벤트 10")
        ]
        
        var recommnedationCells: [MainRecommendCell.State]  = []
        var currentCarouselIndex: Int = 0
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case carouselIndexChanged(Int)
        
        case mainRecommendCell(MainRecommendCell.Action)
    }
    
    public func reduce(
        into state: inout State,
        action: Action
    ) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            state.recommnedationCells = state.eventRecommendations.map {
                MainRecommendCell.State(recommendation: $0)
            }
            return .none
        case .carouselIndexChanged(let index):
            state.currentCarouselIndex = index
            return .none
        default:
            return .none
        }
    }
}
