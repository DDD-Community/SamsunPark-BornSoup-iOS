//
//  Home.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/10/15.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

public struct Home: Reducer {
    public enum HomeCategory: Equatable {
        case curating
        case allContents
    }
    
    public init() {}
    
    public struct State: Equatable {
        var currentCategory: HomeCategory = .curating
        
        var curating: Curating.State = Curating.State(contentsList: [])
        var allContents: AllContens.State = AllContens.State(contentsList: [])
        var allContentsFilter: AllContentsFilter.State = AllContentsFilter.State(filterList: [])
        
        var isContentsFilterPresent: Bool = false
        
        public init(
            currentCategory: HomeCategory = .curating,
            curating: Curating.State,
            allContents: AllContens.State,
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
        
        case curating(Curating.Action)
        case allContents(AllContens.Action)
        case allContentsFilter(AllContentsFilter.Action)
        
        case setContentsFilterSheet(isPresented: Bool)
        case setContentsFilterPresentedCompleted
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
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
                
            case .curating:
                return .none
                
            case .allContents:
                return .none
                
            case let .allContentsFilter(.confirmButtonTapped):
                state.isContentsFilterPresent = false
                return .none
                
            case let .allContentsFilter(.move(source, destination)):
                state.allContents.contentsList.move(fromOffsets: source, toOffset: destination)
                return .none
                
            case .allContentsFilter:
                return .none
            }
        }
        Scope(state: \.curating, action: /Action.curating) {
            Curating()
        }
        Scope(state: \.allContents, action: /Action.allContents) {
            AllContents()
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
        )
    )
}
