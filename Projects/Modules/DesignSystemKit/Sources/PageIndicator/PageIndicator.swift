//
//  PageIndicator.swift
//  DesignSystemKit
//
//  Created by 고병학 on 9/30/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

fileprivate enum Constants {
    static let indicatorSize: CGFloat = 6
    static let indicatorSpacing: CGFloat = 8
}

public struct PageIndicator: View {
    let numberOfPages: Int
    let currentPage: Int
    
    public init(numberOfPages: Int, currentPage: Int) {
        self.numberOfPages = numberOfPages
        self.currentPage = currentPage
    }
    
    public var body: some View {
        HStack(spacing: Constants.indicatorSpacing) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .frame(
                        width: Constants.indicatorSize,
                        height: Constants.indicatorSize
                    )
                    .foregroundColor(index == currentPage ? .main1 : .orangeGray6)
            }
        }
    }
}

#if DEBUG
struct PageIndicator_Previews: PreviewProvider {
    static var previews: some View {
        PageIndicator(numberOfPages: 3, currentPage: 1)
    }
}
#endif
