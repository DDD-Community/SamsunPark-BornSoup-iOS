//
//  SearchView.swift
//  PresentationKit
//
//  Created by 신의연 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

import DesignSystemKit

struct SearchView: View {
    let store: StoreOf<Search>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack {
                        Button {
                            viewStore.send(.dismissButtonTapped)
                        } label: {
                            DesignSystemKitAsset.icBack24.swiftUIImage
                                .renderingMode(.template)
                                .foregroundColor(.orangeGray5)
                        }
                        OZTextField(
                            title: "콘텐츠명이나 지역구를 입력해보세요.",
                            text: viewStore.binding(
                                get: \.text,
                                send: Search.Action.searchTextChanged
                            )
                        )
                    }
                    .padding(.top, 11)
                    .padding(.bottom, 16)
                }
                .padding(.horizontal, 17)
                if !viewStore.recentSearches.isEmpty || viewStore.text.isEmpty {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("최근에 검색하셨어요")
                                .font(.Title2.semiBold)
                                .foregroundColor(.orangeGray1)
                            Spacer()
                            Button(action: {
                                
                            }, label: {
                                Text("전체삭제")
                                    .font(.Body1.regular)
                                    .foregroundColor(.orangeGray5)
                            })
                        }
                        .padding(.top, 28)
                    }
                    .padding(.horizontal, 16)
                } else {
                    SearchResultListView(
                        store: self.store.scope(
                            state: \.searchResultList,
                            action: Search.Action.searchResultList
                        )
                    )
                }
                Spacer()
            }
            .toolbar(.hidden, for: .navigationBar, .tabBar)
        }
    }
}

#Preview {
    SearchView(
        store: Store(
            initialState: Search.State(
                text: "",
                recentSearches: [], 
                searchResultList: SearchResultList.State.init(contentsList: [])),
            reducer: {
                Search()
            }
        )
    )
}
