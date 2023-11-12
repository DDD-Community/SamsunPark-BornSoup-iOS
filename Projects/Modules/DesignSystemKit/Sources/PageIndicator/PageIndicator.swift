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
    let isAccumulated: Bool
    
    public init(
        numberOfPages: Int,
        currentPage: Int,
        isAccumulated: Bool
    ) {
        self.numberOfPages = numberOfPages
        self.currentPage = currentPage
        self.isAccumulated = isAccumulated
    }
    
    public var body: some View {
        HStack(spacing: Constants.indicatorSpacing) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .frame(
                        width: Constants.indicatorSize,
                        height: Constants.indicatorSize
                    )
                    .foregroundColor(getColorOfDot(index))
            }
        }
    }
    
    private func getColorOfDot(_ index: Int) -> Color {
        let isColored: Bool = isAccumulated ? index <= currentPage : index == currentPage
        return isColored ? .main1 : .orangeGray6
    }
}

#if DEBUG
struct PageIndicator_Previews: PreviewProvider {
    static var previews: some View {
        PageIndicator(numberOfPages: 3, currentPage: 1, isAccumulated: true)
    }
}
#endif
