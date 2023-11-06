//
//  HomeView.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/10/15.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

import DomainKit

import DesignSystemKit

struct HomeView: View {
    let store: StoreOf<Home>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack(spacing: 0) {
                    Button {
                        viewStore.send(.categoryChangeButtonTapped(.curating))
                    } label: {
                        VStack {
                            Text(Constants.title1)
                                .font(.Head2.semiBold)
                                .foregroundColor(viewStore.currentCategory == .curating ? .orangeGray1 : .orangeGray5)
                        }
                    }
                    .padding(.trailing, 16)
                    
                    Button {
                        print("button")
                        viewStore.send(.categoryChangeButtonTapped(.allContents))
                    } label: {
                        VStack {
                            Text(Constants.title2)
                                .font(.Head2.semiBold)
                                .foregroundColor(viewStore.currentCategory == .allContents ? .orangeGray1 : .orangeGray5)
                        }
                    }
                    Spacer()
                    Button {
                        print("tapped")
                    } label: {
                        DesignSystemKitAsset.icSearch24.swiftUIImage
                    }
                }
                .padding(.horizontal, 16)
                
                if viewStore.currentCategory == .curating {
                    CuratingView(
                        store: self.store.scope(
                            state: \.curating,
                            action: Home.Action.curating
                        )
                    )
                    .padding(.top, 12)
                    Spacer()
                } else {
                    AllContentsView(
                        store: self.store.scope(
                            state: \.allContents,
                            action: Home.Action.allContents
                        )
                    )
                }
            }
        }
    }
}

#if DEBUG
struct Home_Preview: PreviewProvider {
    static var previews: some View {
        HomeView(
            store: Store(
                initialState: Home.State(
                    curating: Curating.State(contentsList: [
                        PreviewContentsModel.mock,
                        PreviewContentsModel.mock1,
                        PreviewContentsModel.mock,
                        PreviewContentsModel.mock1

                    ]),
                    allContents: AllContens.State(
                        contentsList: [
                            ContentsHorizontalList.State(
                                contentsType: .palace,
                                contents: [
                                    PreviewContents.State(
                                        contents: PreviewContentsModel.mock
                                    ),
                                    PreviewContents.State(
                                        contents: PreviewContentsModel.mock
                                    ),
                                    PreviewContents.State(
                                        contents: PreviewContentsModel.mock
                                    ),
                                    PreviewContents.State(
                                        contents: PreviewContentsModel.mock
                                    )
                                ]
                            ),
                            ContentsHorizontalList.State(
                                contentsType: .review,
                                contents: [
                                    PreviewContents.State(
                                        contents: PreviewContentsModel.mock
                                    ),
                                    PreviewContents.State(
                                        contents: PreviewContentsModel.mock
                                    ),
                                    PreviewContents.State(
                                        contents: PreviewContentsModel.mock
                                    )
                                ]
                            ),
                            ContentsHorizontalList.State(
                                contentsType: .dance,
                                contents: [
                                    PreviewContents.State(
                                        contents: PreviewContentsModel.mock
                                    )
                                ]
                            )
                        ]
                    )
                ),
                reducer: {
                    Home()
                }
            )
        )
    }
}
#endif

extension HomeView {
    enum Constants {
        static let title1: String = "큐레이팅"
        static let title2: String = "모든 콘텐츠"
    }
}
