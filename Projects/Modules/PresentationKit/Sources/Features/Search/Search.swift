//
//  Search.swift
//  PresentationKit
//
//  Created by 신의연 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import Foundation

public struct Search: Reducer {
    public init() {}
    
    public struct State: Equatable {
        var isBackButtonHidden: Bool = false
        var text: String = ""
        var recentSearches: [String]
        var searchResultList: SearchResultList.State = .init(contentsList: [
            PreviewContentsModel.mock,
            PreviewContentsModel.mock1
        ])
        var selectedModel: PreviewContentsModel?
        
        public init(
            text: String,
            recentSearches: [String],
            searchResultList: SearchResultList.State,
            isBackButtonHidden: Bool = false
        ) {
            self.text = text
            self.recentSearches = recentSearches
            self.searchResultList = searchResultList
            self.isBackButtonHidden = isBackButtonHidden
        }
    }
    
    public enum Action: Equatable {
        case searchTextChanged(String)
        case dismissButtonTapped
        case setSearchResult([PreviewContentsModel])
        case searchResultList(SearchResultList.Action)
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.searchUseCase) var searchUseCase
    @Dependency(\.mainQueue) var mainQueue
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .searchTextChanged(let search):
                state.text = search
                return .run { [search] send async in
                    guard let result = await searchUseCase.searchContentsWithTitle(search),
                          let searchResultList = result.body?.infos else {
                        return
                    }
                    let contentsList: [PreviewContentsModel] = searchResultList.map({ .from($0) })
                    await send(.setSearchResult(contentsList))
                }
                .debounce(id: "debounce_textfield", for: 1, scheduler: mainQueue)
                
            case .searchResultList(.cellTapped(let model)):
                state.selectedModel = model
                return .send(.dismissButtonTapped)
                
            case .searchResultList:
                return .none
                
            case .setSearchResult(let models):
                state.searchResultList = .init(contentsList: models)
                return .none
                
            case .dismissButtonTapped:
                return .run { _ in
                    await self.dismiss()
                }
            }
        }
    }
}
