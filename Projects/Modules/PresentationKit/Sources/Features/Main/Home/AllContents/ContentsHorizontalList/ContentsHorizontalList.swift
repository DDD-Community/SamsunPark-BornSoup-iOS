//
//  ContentsHorizontalList.swift
//  PresentationKit
//
//  Created by 신의연 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation
import ComposableArchitecture

import DomainKit

public struct ContentsHorizontalList: Reducer {
    public struct State: Equatable, Identifiable {
        public let id = UUID()
        public var contentsType: ContentsType = .palace
        public var contents: IdentifiedArrayOf<PreviewContents.State> = []
    }
    
    public enum Action: Equatable {
        case onAppear
        case contents(id: PreviewContents.State.ID, action: PreviewContents.Action)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .contents:
                return .none
            }
        }
        .forEach(\.contents, action: /Action.contents) {
            PreviewContents()
        }
    }
}

extension ContentsHorizontalList.State {
    public static let placeHolder = ContentsHorizontalList.State(
        contents: [
            PreviewContents.State.placeHolder,
            PreviewContents.State.placeHolder,
            PreviewContents.State.placeHolder,
            PreviewContents.State.placeHolder
        ]
    )
}
