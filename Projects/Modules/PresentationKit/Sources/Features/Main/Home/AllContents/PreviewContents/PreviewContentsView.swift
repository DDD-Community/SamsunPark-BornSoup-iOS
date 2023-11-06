//
//  ContentsPreview.swift
//  PresentationKit
//
//  Created by 신의연 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

import Kingfisher

public struct PreviewContentsView: View {
    let store: StoreOf<PreviewContents>
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                KFImage(URL(string: viewStore.contents.thumbnail[0]))
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: 160, height: 226)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                    .padding(.bottom, 16)
                
                Text(viewStore.contents.title)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .font(.Body1.semiBold)
                    .foregroundColor(.orangeGray1)
                    .padding(.bottom, 8)
                
                HStack(alignment: .center, spacing: 0) {
                    Text(viewStore.contents.category.rawValue)
                        .font(.Body1.semiBold)
                        .foregroundColor(.main1)
                        .padding(.trailing, 8)
                    Divider()
                        .frame(maxHeight: 16)
                        .padding(.trailing, 8)
                    Text(viewStore.contents.area)
                        .font(.Body1.regular)
                        .foregroundColor(.orangeGray2) +
                    Text(",")
                        .font(.Body1.regular)
                        .foregroundColor(.orangeGray2) +
                    Text(viewStore.contents.place)
                        .font(.Body1.regular)
                        .foregroundColor(.orangeGray2)
                }
                .padding(.bottom, 12)
                
                HStack(spacing: 0) {
                    Text(viewStore.contents.startDate)
                        .font(.Body1.regular)
                        .foregroundColor(.orangeGray2) +
                    Text("~")
                        .font(.Body1.regular)
                        .foregroundColor(.orangeGray2) +
                    Text((viewStore.contents.endDate).split(separator: ".")[1] + "." + (viewStore.contents.endDate).split(separator: ".")[2])
                        .font(.Body1.regular)
                        .foregroundColor(.orangeGray2)
                }
            }
            .frame(maxWidth: 160)
        }
    }
}

#Preview {
    PreviewContentsView(
        store: Store(
            initialState: PreviewContents.State.placeHolder,
            reducer: {
                PreviewContents()
            }
        )
    )
}

extension PreviewContentsView {
    enum Constants {
        static let cornerRadius: CGFloat = 10
    }
}
