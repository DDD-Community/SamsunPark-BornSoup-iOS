//
//  ContentsHorizontalListView.swift
//  PresentationKit
//
//  Created by 신의연 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import DomainKit

import SwiftUI

public struct ContentsHorizontalListView: View {
    let store: StoreOf<ContentsHorizontalList>
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .bottom) {
                    HStack(spacing: 0) {
                        Text((viewStore.contentsType.rawValue))
                            .font(.Title1.semiBold)
                            .foregroundColor(.main1) + Text(viewStore.contentsType.convertToListTitle())
                            .font(.Title1.semiBold)
                            .foregroundColor(.orangeGray1)
                    }
                    Spacer()
                    Text(Constants.primaryButtonTitle)
                        .font(.Body1.regular)
                        .foregroundColor(.orangeGray5)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 30)
                
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEachStore(
                            self.store.scope(
                                state: \.contents,
                                action: ContentsHorizontalList.Action.contents
                            )
                        ) { store in
                            LazyVStack {
                                PreviewContentsView(store: store)
                            }
                        }
                    }
                    .padding(.leading, 16)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    VStack {
        ContentsHorizontalListView(
            store: Store(
                initialState: ContentsHorizontalList.State(
                    contents: [
                        PreviewContents.State(contents: PreviewContentsModel.mock),
                        PreviewContents.State(contents: PreviewContentsModel.mock1),
                        PreviewContents.State(contents: PreviewContentsModel.mock),
                        PreviewContents.State(contents: PreviewContentsModel.mock1)
                    ]
                )
                ,
                reducer: {
                    ContentsHorizontalList()
                }
            )
        )
    }
}

extension ContentsHorizontalListView {
    enum Constants {
        static let primaryButtonTitle: String = "전체보기"
    }
}
