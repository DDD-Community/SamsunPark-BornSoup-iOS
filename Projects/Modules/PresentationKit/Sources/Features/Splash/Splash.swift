//
//  Splash.swift
//  PresentationKit
//
//  Created by 고병학 on 9/30/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import Foundation

public struct Splash: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
        var isNeedToDismiss: Bool = false
        
        @BindingState var isLogoHidden: Bool = true
        @BindingState var isTextHidden: Bool = true
    }
    
    public enum Action {
        case dismissSplashView
        case appearLogoImage
        case appearText
    }
    
    @Dependency(\.continuousClock) var clock
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .dismissSplashView:
                return .none
            case .appearLogoImage:
                state.isLogoHidden = false
                return .run { send in
                    try await self.clock.sleep(for: .milliseconds(800))
                    await send(.appearText, animation: .easeOut(duration: 1))
                }
            case .appearText:
                state.isTextHidden = false
                return .none
            }
        }
    }
}
