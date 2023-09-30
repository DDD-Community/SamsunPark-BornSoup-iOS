//
//  AppView.swift
//  OZeon
//
//  Created by 고병학 on 9/30/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import PresentationKit

import SwiftUI

public struct AppView: View {
    let store: StoreOf<AppFeature>
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            SplashView(store: Store(initialState: Splash.State()) {
                Splash()
            })
        }
    }
}
