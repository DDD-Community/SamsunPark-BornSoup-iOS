//
//  PaginationNavBar.swift
//  DesignSystemKit
//
//  Created by 고병학 on 10/1/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public struct PaginationNavBar: View {
    public init(
        title: String,
        numberOfPages: Int,
        currentPage: Int,
        backButtonAction: @escaping () -> Void
    ) {
        self.title = title
        self.numberOfPages = numberOfPages
        self.currentPage = currentPage
        self.backButtonAction = backButtonAction
    }
    
    let title: String
    let numberOfPages: Int
    let currentPage: Int
    let backButtonAction: () -> Void
    
    public var body: some View {
        ZStack {
            HStack {
                Button(action: backButtonAction, label: {
                    DesignSystemKitAsset.icBack24.swiftUIImage
                        .frame(width: 24, height: 24)
                })
                Spacer()
                PageIndicator(numberOfPages: numberOfPages, currentPage: currentPage)
            }
            
            Text(title)
                .font(.Head2.semiBold)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.orangeGray1)
        }
        .frame(maxWidth: .infinity, minHeight: 24, maxHeight: 24)
        .padding(.horizontal, 16)
        .padding(.top, 17)
        .padding(.bottom, 16)
    }
}

#if DEBUG
struct PaginationNavBar_Previews: PreviewProvider {
    static var previews: some View {
        PaginationNavBar(
            title: "닉네임 설정",
            numberOfPages: 3,
            currentPage: 1,
            backButtonAction: {}
        )
    }
}
#endif
