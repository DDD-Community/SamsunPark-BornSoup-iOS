//
//  CuratingContentsView.swift
//  PresentationKit
//
//  Created by 신의연 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

import DomainKit
import Kingfisher

struct CuratingContentsView: View {
    let contents: PreviewContentsModel
    
    var body: some View {
        ZStack {
            KFImage(URL(string: contents.thumbnail[0]))
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
                    Text(contents.category.rawValue)
                        .foregroundColor(Color.ozWhite)
                    
                    Text(contents.title)
                        .font(.Head2.semiBold)
                        .foregroundColor(Color.ozWhite)
                        .padding(.top, 20)
                    
                    HStack(alignment: .center, spacing: 8) {
                        Text("\(contents.area), \(contents.place)")
                        Rectangle()
                            .frame(width: 1, height: 16)
                        Text("\(contents.startDate) ~ \(String(contents.endDate.split(separator:".")[1])).\(String(contents.endDate.split(separator: ".")[2]))")
                        Spacer()
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

#Preview {
    CuratingContentsView(
        contents: PreviewContentsModel.mock1
    )
}

extension CuratingContentsView {
    enum Constants {
        static let cornerRadius: CGFloat = 30
    }
}
