//
//  AllContentsView.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/10/15.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

import DomainKit

public struct AllContentsView: View {
    let store: StoreOf<AllContens>
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack(spacing: 8) {
                    ForEachStore(
                        self.store.scope(
                            state: \.contentsList,
                            action: AllContens.Action.contentsList
                        )
                    ) { store in
                        ContentsHorizontalListView(
                            store: store)
                    }
                    .padding(.vertical, 30)
                    .background(Color.white)
                }
                .padding(.top, 8)
                .background(Color(UIColor.systemGray5))
                
            }
        }
    }
}

#Preview {
    AllContentsView(
        store: Store(
            initialState: AllContens.State(
                contentsList: [
                    ContentsHorizontalList.State(
                        contentsType: .experience,
                        contents: [
                            PreviewContents.State(contents: PreviewContentsModel.mock),
                            PreviewContents.State(contents: PreviewContentsModel.mock1),
                            PreviewContents.State(contents: PreviewContentsModel.mock),
                            PreviewContents.State(contents: PreviewContentsModel.mock1)
                        ]),
                    ContentsHorizontalList.State(
                        contentsType: .palace,
                        contents: [
                            PreviewContents.State(contents: PreviewContentsModel.mock),
                            PreviewContents.State(contents: PreviewContentsModel.mock1),
                            PreviewContents.State(contents: PreviewContentsModel.mock),
                            PreviewContents.State(contents: PreviewContentsModel.mock1)
                        ])
                ]
            ), reducer: {
                AllContens()
            }
        )
    )
}
