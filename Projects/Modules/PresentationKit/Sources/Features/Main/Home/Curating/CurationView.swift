//
//  CurationView.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/09/30.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI
import DesignSystemKit

public struct CurationView: View {
    let store: StoreOf<Recommendation>
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                    Text(viewStore.title)
                        .font(.Head0.semiBold)
                        .foregroundColor(.orangeGray1)
                    Text(viewStore.categoryTitle)
                        .font(.Head0.semiBold)
                        .foregroundColor(.orangeGray1)
                    IfLetStore(store.scope(state: \.splash, action: Recommendation.Action.splash)) { store in
                        SplashView(store: store)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct Recommendation_PreView: PreviewProvider {
    static var previews: some View {
        RecommendationView(
            store: Store(
                initialState: Recommendation.State( recommendationList: []
                                                  ),
                reducer: {
                    Recommendation()
                }
            )
        )
    }
}
#endif
