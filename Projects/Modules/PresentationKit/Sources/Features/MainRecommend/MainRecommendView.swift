//
//  MainRecommendView.swift
//  PresentationKit
//
//  Created by 고병학 on 2023/07/29.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

public struct MainRecommendView: View {
    
    let store: StoreOf<MainRecommend>
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Text("MainRecommendView")
                Text("\(viewStore.eventRecommendations.count)")

                Carousel(
                    spacing: 16,
                    trailingSpace: 64,
                    index: viewStore.binding(
                        get: \.currentCarouselIndex,
                        send: MainRecommend.Action.carouselIndexChanged
                    ),
                    items: viewStore.eventRecommendations
                ) { recommendation in
                    if let cellIndex: Int = viewStore.recommnedationCells
                        .firstIndex(where: { $0.recommendation.id == recommendation.id }) {
                        MainRecommendCellView(
                            store: self.store.scope(
                                state: \.recommnedationCells[cellIndex],
                                action: MainRecommend.Action.mainRecommendCell
                            )
                        )
                    }
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
        
    }
}
