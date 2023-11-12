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
    let store: StoreOf<AllContents>
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 8) {
                ScrollView {
                    ForEachStore(
                        self.store.scope(
                            state: \.contentsList,
                            action: AllContents.Action.contentsList
                        )
                    ) { store in
                        ContentsHorizontalListView(
                            store: store)
                        .padding(.vertical, 30)
                        .background(Color.white)
                    }
                    .background(Color(UIColor.systemGray5))
                }
            }
        }
    }
}

#Preview {
    VStack {
        AllContentsView(
            store: Store(
                initialState: AllContents.State(
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
                    AllContents()
                }
            )
        )
    }
}
