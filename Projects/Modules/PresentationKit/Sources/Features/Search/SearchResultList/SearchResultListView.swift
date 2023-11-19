//
//  SearchResultListView.swift
//  PresentationKit
//
//  Created by 신의연 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import Kingfisher

struct SearchResultListView: View {
    let store: StoreOf<SearchResultList>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            LazyVStack(spacing: 0) {
                ForEach(viewStore.contentsList, id: \.self) { contents in
                    HStack(spacing: 20) {
                        KFImage(URL(string:  contents.thumbnails[0]))
                            .frame(maxWidth: 96, maxHeight: 96)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        VStack(alignment: .leading, spacing: 0) {
                            Text(contents.title)
                                .font(.Title2.semiBold)
                                .foregroundColor(.orangeGray1)
                                .padding(.bottom, 12)
                            HStack {
                                Text(contents.category.rawValue)
                                    .font(.Body3.semiBold)
                                    .foregroundColor(.main1)
                                Divider()
                                    .frame(height: 12)
                                Text(contents.city)
                                    .font(.Body3.regular)
                                    .foregroundColor(.orangeGray2)
                                Divider()
                                    .frame(height: 12)
                                Text("\(contents.startDate) ~ \(String(contents.endDate.split(separator:".")[1])).\(String(contents.endDate.split(separator: ".")[2]))")
                                    .font(.Body3.regular)
                                    .foregroundColor(.orangeGray2)
                            }
                        }
                    }
                }
            }
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
