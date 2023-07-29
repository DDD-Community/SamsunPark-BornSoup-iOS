//
//  Main.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/07/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import Foundation

public struct Main: ReducerProtocol {
    public struct State: Equatable {
        var responseStr: String = ""
        
        var mainRecommend = MainRecommend.State()
    }
    
    public enum Action: Equatable {
        case fetchButtonTapped
        case fetchResponse(TaskResult<String>)
        
        case mainRecommendAction(MainRecommend.Action)
    }
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchButtonTapped:
    //            return .run { send in 모듈 구현 해 주세욥
    //                await send(
    //                    .fetchResponse(
    //                        TaskResult {
    //                            try await self.factClient.fetch()
    //                        }
    //                    )
    //                )
    //            }
                return .none
            case .fetchResponse(.success(let response)):
                state.responseStr = response
                return .none
            case .fetchResponse(.failure(let error)):
                print("\(error)")
                return .none
            default:
                return .none
            }
        }
        Scope(state: \.mainRecommend, action: /Action.mainRecommendAction) {
            MainRecommend()
        }
        
    }
}
