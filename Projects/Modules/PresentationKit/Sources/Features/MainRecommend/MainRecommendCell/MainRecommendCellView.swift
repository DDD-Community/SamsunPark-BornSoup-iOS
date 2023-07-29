//
//  MainRecommendCellView.swift
//  PresentationKit
//
//  Created by 고병학 on 2023/07/29.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import DomainKit
import Kingfisher

import SwiftUI

struct MainRecommendCellView: View {
    let store: StoreOf<MainRecommendCell>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                KFImage(URL(string: "https://placehold.co/400x600.png"))
                    .resizable()
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 326, height: 294.42584)
                    .position(x: 163, y: 403.78708)
                    .background(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: .black.opacity(0), location: 0.00),
                                Gradient.Stop(color: .black.opacity(0.7), location: 1.00)
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                    )
                
                VStack(alignment: .leading) {
                    Spacer()
                    HStack {
                        VStack(alignment: .leading) {
                            RecommendCellInfoView(
                                title: viewStore.recommendation.title,
                                date: "2023. 4. 13.~6. 4.",
                                place: "서울, 종로구"
                            )
                            ReservationButton()
                        }
                        Spacer()
                    }
                }
                .padding([.leading, .bottom], 16)
            }
            .frame(width: 326, height: 551)
            .cornerRadius(20)
        }
    }
}
