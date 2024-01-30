//
//  NeighborhoodView.swift
//  PresentationKit
//
//  Created by 신의연 on 12/3/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI
import MapKit
import CoreLocation
import DesignSystemKit

struct NeighborhoodView: View {
    let store: StoreOf<Neighborhood>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            if #available(iOS 17.0, *) {
                if true {
                    ZStack {
                        OZMapView(
                            region: viewStore.binding(
                                get: \.region,
                                send: Neighborhood.Action.regionChanged
                            ),
                            visibleRect: viewStore.binding(
                                get: \.visibleRect,
                                send: Neighborhood.Action.visibleRectChanged
                            ),
                            annotations: viewStore.contentsAnnotationList
                        )
                        .ignoresSafeArea()
                        
                        VStack {
                            OZTextField(
                                title: "콘텐츠명이나 지역구를 입력해보세요.",
                                text: viewStore.binding(
                                    get: \.text,
                                    send: Neighborhood.Action.searchTextChanged
                                )
                            )
                            .background(Color.ozWhite)
                            .cornerRadius(23)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(Array(viewStore.selectableCategories.enumerated()), id: \.0) { index ,selectableCategories in
                                        HStack {
                                            ChipButton(
                                                text: "\(selectableCategories.category.rawValue)",
                                                leadingImage: selectableCategories.getContentsImage(),
                                                trailingImage: nil,
                                                isSelected: selectableCategories.isSelected
                                            )
                                        }
                                        .background(Color.ozWhite)
                                        .clipShape(RoundedRectangle(cornerRadius: 23))
                                        .onTapGesture {
                                            print(index)
                                            viewStore.send(.categorySelected(index))
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            Spacer()
                        }
                    }
                    .onAppear {
                        viewStore.send(.onAppear)
                    }
                } else {
                    SearchView(
                        store: self.store.scope(
                            state: \.search,
                            action: Neighborhood.Action.search
                        )
                    )
                }
            } else {
                Text("iOS 최신 버전 업데이트가 필요합니다(17.0 이상)")
            }
        }
    }
}

#Preview {
    NeighborhoodView(
        store: Store(
            initialState: Neighborhood.placeholder,
            reducer: {
                Neighborhood()
            }
        )
    )
}
