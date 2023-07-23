//
//  Main.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/07/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation
import ComposableArchitecture

public struct Main: ReducerProtocol {
    public struct State: Equatable {
        var responseStr: String = ""
    }
    
    public enum Action: Equatable {
        case fetchButtonTapped
        case fetchResponse(TaskResult<String>)
    }
    
    
    public func reduce(
        into state: inout State,
        action: Action
    ) -> EffectTask<Action> {
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
        }
    }
}
