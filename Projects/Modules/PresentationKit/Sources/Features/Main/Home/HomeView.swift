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

public struct HomeView: View {
    let store: StoreOf<Home>
    
    public init(store: StoreOf<Home>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(
            self.store.scope(state: \.path, action: { .path($0) })
        ) {
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
                            viewStore.send(.searchButtonTapped)
                        } label: {
                            DesignSystemKitAsset.icSearch24.swiftUIImage
                        }
                        if viewStore.currentCategory == .allContents {
                            Button {
                                viewStore.send(.setContentsFilterSheet(isPresented: true))
                            } label: {
                                DesignSystemKitAsset.icSwap22.swiftUIImage
                            }
                            .padding(.leading, 16)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 17)
                    
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
                .sheet(
                    isPresented: viewStore.binding(
                        get: \.isContentsFilterPresent,
                        send: Home.Action.setContentsFilterSheet),
                    content: {
                        AllContentsFilterView(
                            store: self.store.scope(
                                state: \.allContentsFilter,
                                action: Home.Action.allContentsFilter
                            )
                        )
                    }
                )
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        } destination: {
            switch $0 {
            case .search:
                CaseLet(
                    /Home.Path.State.search,
                     action: Home.Path.Action.search,
                     then: SearchView.init(store:)
                )
            }
        }
    }
}

#if DEBUG
struct Home_Preview: PreviewProvider {
    static var previews: some View {
        HomeView(store: .init(initialState: Home.State.mock, reducer: {
            Home()
        }))
    }
}
#endif

extension HomeView {
    enum Constants {
        static let title1: String = "큐레이팅"
        static let title2: String = "모든 콘텐츠"
    }
}
