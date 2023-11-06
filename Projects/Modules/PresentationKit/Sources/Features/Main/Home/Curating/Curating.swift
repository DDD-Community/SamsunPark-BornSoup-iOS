//
//  Curating.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/09/30.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//
import ComposableArchitecture

import Foundation
import DomainKit

public struct Curating: Reducer {
    public struct State: Equatable {
        var contentsList: [PreviewContentsModel] = []
    }
    
    public enum Action: Equatable {
        case onAppear
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            }
        }
    }
}

extension Curating.State {
    
}
