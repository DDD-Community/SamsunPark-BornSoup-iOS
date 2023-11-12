//
//  PreviewContents.swift
//  PresentationKit
//
//  Created by 신의연 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation
import ComposableArchitecture

import DomainKit

public struct PreviewContents: Reducer {
    public struct State: Hashable, Identifiable {
        public let id = UUID()
        public let contents: PreviewContentsModel
        
        public init(contents: PreviewContentsModel) {
            self.contents = contents
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        case contentsTapped
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .contentsTapped:
                return .none
            }
        }
    }
}

extension PreviewContents.State {
    static let placeHolder = PreviewContents.State(contents: PreviewContentsModel.mock)
}
