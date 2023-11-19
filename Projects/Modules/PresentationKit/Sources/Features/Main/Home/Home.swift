//
//  Home.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/10/15.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import DIKit
import DomainKit

import Foundation

public struct Home: Reducer {
    public enum HomeCategory: Equatable {
        case curating
        case allContents
    }
    
    public init() {}
    
    public struct State: Equatable {
        var currentCategory: HomeCategory = .curating
        
        var curating: Curating.State = Curating.State(contentsList: [])
        var allContents: AllContents.State = AllContents.State(contentsList: [])
        var allContentsFilter: AllContentsFilter.State = AllContentsFilter.State(filterList: [])
        
        var isContentsFilterPresent: Bool = false
        
        var path = StackState<Path.State>()
        
        public init(
            currentCategory: HomeCategory = .curating,
            curating: Curating.State,
            allContents: AllContents.State,
            allContentsFilter: AllContentsFilter.State,
            isContentsFilterPresent: Bool = false
        ) {
            self.currentCategory = currentCategory
            self.curating = curating
            self.allContents = allContents
            self.allContentsFilter = allContentsFilter
            self.isContentsFilterPresent = isContentsFilterPresent
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        case categoryChangeButtonTapped(HomeCategory)
        case searchButtonTapped
        
        case curating(Curating.Action)
        case allContents(AllContents.Action)
        case allContentsFilter(AllContentsFilter.Action)
        
        case setContentsFilterSheet(isPresented: Bool)
        case setContentsFilterPresentedCompleted
        
        case contentsListResponse(TaskResult<ContentsListResponse>)
        
        case path(StackAction<Path.State, Path.Action>)
    }
    
    @Dependency(\.homeUseCase) var homeUseCase
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    await send(.contentsListResponse(TaskResult {
                        try await self.homeUseCase.requestContentsList()
                    }))
                }
                
            case .setContentsFilterSheet(isPresented: true):
                state.isContentsFilterPresent = true
                return .none
                
            case .setContentsFilterSheet(isPresented: false):
                state.isContentsFilterPresent = false
                return .none
                
            case .setContentsFilterPresentedCompleted:
                return .none
                
            case let .categoryChangeButtonTapped(category):
                state.currentCategory = category
                return .none
                
            case .searchButtonTapped:
                state.path.append(.search(.init(text: "", recentSearches: [], searchResultList: SearchResultList.State.init(contentsList: []))))
                return .none
                
            case .curating:
                return .none
                
            case .allContents:
                return .none
                
            case .allContentsFilter(.confirmButtonTapped):
                state.isContentsFilterPresent = false
                return .none
                
            case let .allContentsFilter(.move(source, destination)):
                state.allContents.contentsList.move(fromOffsets: source, toOffset: destination)
                return .none
                
            case .allContentsFilter:
                return .none
                
            case let .contentsListResponse(result):
                switch result {
                case .success(let contentsListResponse):
                    if let contentsList = contentsListResponse.body?.infos {
                        let previewContentsList = contentsList.map {
                            PreviewContentsModel.from($0)
                        }
                        state.curating = Curating.State(
                            contentsList: previewContentsList
                        )
                        //TODO: - data 넣은 이후 다시 작업
                        //state.allContents = AllContents.State(contentsList: T##IdentifiedArrayOf<ContentsHorizontalList.State>)
                    }
                    return .none
                case .failure(let error):
                    return .none
                }
                
            case .path(let action):
                switch action {
                case .element(id: _, action: .search):
                    return .none
                default:
                    return .none
                }
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
        Scope(state: \.curating, action: /Action.curating) {
            Curating()
        }
        Scope(state: \.allContents, action: /Action.allContents) {
            AllContents()
        }
    }
    
    public struct Path: Reducer {
        public enum State: Equatable {
            case search(Search.State = .init(text: "", recentSearches: [], searchResultList: SearchResultList.State.init(contentsList: [])))
        }
        
        public enum Action: Equatable {
            case search(Search.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.search, action: /Action.search) {
                Search()
            }
        }
    }
}

extension Home.State {
    static let mock = Home.State(
        curating: Curating.State(contentsList: [
            PreviewContentsModel.mock,
            PreviewContentsModel.mock1,
            PreviewContentsModel.mock,
            PreviewContentsModel.mock1
            
        ]),
        allContents: AllContents.State(
            contentsList: [
                ContentsHorizontalList.State(
                    contentsType: .palace,
                    contents: [
                        PreviewContents.State(
                            contents: PreviewContentsModel.mock
                        ),
                        PreviewContents.State(
                            contents: PreviewContentsModel.mock
                        ),
                        PreviewContents.State(
                            contents: PreviewContentsModel.mock
                        ),
                        PreviewContents.State(
                            contents: PreviewContentsModel.mock
                        )
                    ]
                ),
                ContentsHorizontalList.State(
                    contentsType: .review,
                    contents: [
                        PreviewContents.State(
                            contents: PreviewContentsModel.mock
                        ),
                        PreviewContents.State(
                            contents: PreviewContentsModel.mock
                        ),
                        PreviewContents.State(
                            contents: PreviewContentsModel.mock
                        )
                    ]
                ),
                ContentsHorizontalList.State(
                    contentsType: .dance,
                    contents: [
                        PreviewContents.State(
                            contents: PreviewContentsModel.mock
                        )
                    ]
                )
            ]
        ), allContentsFilter: .init(filterList: [
            ContentsHorizontalList.State(
                contentsType: .palace,
                contents: [
                    PreviewContents.State(
                        contents: PreviewContentsModel.mock
                    ),
                    PreviewContents.State(
                        contents: PreviewContentsModel.mock
                    ),
                    PreviewContents.State(
                        contents: PreviewContentsModel.mock
                    ),
                    PreviewContents.State(
                        contents: PreviewContentsModel.mock
                    )
                ]
            ),
            ContentsHorizontalList.State(
                contentsType: .review,
                contents: [
                    PreviewContents.State(
                        contents: PreviewContentsModel.mock
                    ),
                    PreviewContents.State(
                        contents: PreviewContentsModel.mock
                    ),
                    PreviewContents.State(
                        contents: PreviewContentsModel.mock
                    )
                ]
            ),
            ContentsHorizontalList.State(
                contentsType: .dance,
                contents: [
                    PreviewContents.State(
                        contents: PreviewContentsModel.mock
                    )
                ]
            )
        ])
    )
}
