//
//  Recommendation.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/09/30.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//
import ComposableArchitecture

import Foundation

public struct Curation: Reducer {
    private enum Constants: Equatable {
        static let recommendationTitle = "큐레이팅"
        static let categoryTitle = "모든 콘텐츠"
    }
    
    public struct State: Equatable {
        var recommendationList: [String] = Array(repeating: "sample", count: 10)
        var splash: Splash.State?
        let title: String = Constants.recommendationTitle
        let categoryTitle: String = Constants.categoryTitle
        
        public init(
            recommendationList: [String]
        ) {
            self.recommendationList = recommendationList
        }
    }
    
    public enum Action: Equatable {
        case sample
        case splash(Splash.Action)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .sample:
                return .none
            case .splash:
                return .none
            }
        }
        .ifLet(\.splash, action: /Action.splash) {
            Splash()
        }
    }
}

extension Curation.State {
    
}
