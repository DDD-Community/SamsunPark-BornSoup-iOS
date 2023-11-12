//
//  Search.swift
//  PresentationKit
//
//  Created by 신의연 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation
import ComposableArchitecture

public struct Search: Reducer {
    public struct State: Equatable {
        var text: String = ""
        var recentSearches: [String]
        var searchResultList: SearchResultList.State = .init(contentsList: [
            PreviewContentsModel.mock,
            PreviewContentsModel.mock1
        ])
        
        public init(
            text: String,
            recentSearches: [String],
            searchResultList: SearchResultList.State
        ) {
            self.text = text
            self.recentSearches = recentSearches
            self.searchResultList = searchResultList
        }
    }
    
    public enum Action: Equatable {
        case searchTextChanged(String)
        case dismissButtonTapped
        case searchResultList(SearchResultList.Action)
    }
    
    @Dependency(\.dismiss) var dismiss
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .searchTextChanged(let search):
                state.text = search
                return .none
                
            case .searchResultList(.cellTapped):
                return .none
                
            case .searchResultList:
                return .none
                
            case .dismissButtonTapped:
                return .run { send in
                    await self.dismiss()
                }
            }
        }
    }
}
