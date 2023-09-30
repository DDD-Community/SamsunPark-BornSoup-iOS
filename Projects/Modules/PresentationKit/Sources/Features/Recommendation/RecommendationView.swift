//
//  RecommendationView.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/09/30.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct RecommendationView: View {
    let store: StoreOf<Recommendation>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                    Text("추천")
                        .font(.Head0.semiBold)
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
                initialState: Recommendation.State(),                            reducer: {
                    Recommendation()
                }
            )
        )
    }
}
#endif
