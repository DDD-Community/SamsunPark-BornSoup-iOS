//
//  CurationContentsView.swift
//  PresentationKit
//
//  Created by 신의연 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

import DomainKit
import Kingfisher

struct CurationContentsView: View {
    let store: StoreOf<CurationContent>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                KFImage(URL(string: "https://picsum.photos/400/600"))
                    .resizable()
                
                    .clipped()
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: Constants.cornerRadius
                        )
                    )
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(
                        Gradient(colors: [.clear, .black])
                            .opacity(0.4)
                        )
                    
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                    
                    
                    VStack(alignment: .leading, spacing: 0) {
                        //TODO: - tag or badge 만들어서 merge 다시 해야 함
                        Text(viewStore.previewContents.category.rawValue)
                        .foregroundColor(Color.ozWhite)
                        
                        Text(viewStore.previewContents.title)
                            .font(.Head2.semiBold)
                            .foregroundColor(Color.ozWhite)
                            .padding(.top, 20)
                        
                        HStack(alignment: .center, spacing: 8) {
                            Text("\(viewStore.previewContents.area), \(viewStore.previewContents.place)")
                            Rectangle()
                                .frame(width: 1, height: 16)
                            Text("\(viewStore.previewContents.startDate) ~ \(String(viewStore.previewContents.endDate.split(separator:".")[1])).\(String(viewStore.previewContents.endDate.split(separator: ".")[2]))")
                                
                        }
                        .font(.Body1.regular)
                        .foregroundColor(Color.ozWhite)
                        .padding(.top, 20)
                    }
                    .padding(.bottom, 30)
                    .padding(.horizontal, 30)
                }
            }
        }
    }
}

#Preview {
    CurationContentsView(
        store: Store(
            initialState: CurationContent.State(
                previewContents: PreviewContentsModel.mock
            ),
            reducer: {
                CurationContent()
            }
        )
    )
}

extension CurationContentsView {
    enum Constants {
        static let cornerRadius: CGFloat = 30
    }
}
