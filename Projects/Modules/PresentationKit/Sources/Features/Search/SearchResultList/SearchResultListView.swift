//
//  SearchResultListView.swift
//  PresentationKit
//
//  Created by 신의연 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import CoreKit
import Kingfisher
import SwiftUI

struct SearchResultListView: View {
    let store: StoreOf<SearchResultList>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
//            LazyVStack(spacing: 8) {
            List {
                ForEach(viewStore.contentsList, id: \.self) { contents in
                    HStack(spacing: 20) {
                        KFImage(URL(string: contents.thumbnails[0]))
                            .frame(maxWidth: 96, maxHeight: 96)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text(contents.title)
                                    .font(.Title2.semiBold)
                                    .foregroundColor(.orangeGray1)
                                    .padding(.bottom, 12)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            
                            HStack {
                                Text(contents.category.rawValue)
                                    .font(.Body3.semiBold)
                                    .foregroundColor(.main1)
                                Divider()
                                    .frame(height: 12)
                                Text(contents.city ?? "")
                                    .font(.Body3.regular)
                                    .foregroundColor(.orangeGray2)
                                Divider()
                                    .frame(height: 12)
                                Text("\(contents.startDate) ~ \(String(contents.endDate.split(separator: ".")[safe: 1] ?? "")).\(String(contents.endDate.split(separator: ".")[safe: 2] ?? ""))")
                                    .font(.Body3.regular)
                                    .foregroundColor(.orangeGray2)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .onTapGesture {
                        viewStore.send(.cellTapped(contents))
                    }
                }
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .listSectionSeparator(.hidden)
        }
    }
}

#Preview {
    SearchResultListView(
        store: Store(
            initialState: SearchResultList.State(
                contentsList: [
                    PreviewContentsModel.mock
                ]
            ),
            reducer: {
                SearchResultList()
            }
        )
    )
}
