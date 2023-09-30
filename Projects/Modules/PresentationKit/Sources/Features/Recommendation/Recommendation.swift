//
//  Recommendation.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/09/30.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct Recommendation: Reducer {
    struct State {
        var sample = ""
        var recommendationList: [String] = Array(repeating: "sample", count: 10)
        
    }
    
    enum Action {
        case sample
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .sample:
                return .none
            }
        }
    }
}
