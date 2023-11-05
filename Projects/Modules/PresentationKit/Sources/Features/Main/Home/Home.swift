//
//  Home.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/10/15.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct Home: Reducer {
    enum HomeCategory: Equatable {
        case curating
        case allContents
    }
    
    struct State: Equatable {
        var currentCategory: HomeCategory = .curating
        
        var curating: Curating.State = Curating.State(contentsList: [])
        var allContents: AllContens.State = AllContens.State(contentsList: [])
    }
    
    enum Action: Equatable {
        case onAppear
        case categoryChangeButtonTapped(HomeCategory)
        
        case curating(Curating.Action)
        case allContents(AllContens.Action)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                
                return .none
                
            case let .categoryChangeButtonTapped(category):
                print(category)
                state.currentCategory = category
                return .none
                
            case .curating:
                return .none
                
            case .allContents:
                return .none
            }
        }
        Scope(state: \.curating, action: /Action.curating) {
            Curating()
        }
        Scope(state: \.allContents, action: /Action.allContents) {
            AllContens()
        }
    }
}
