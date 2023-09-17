//
//  CalendarImageCardButton.swift
//  PresentationKit
//
//  Created by 고병학 on 2023/09/03.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Kingfisher

import SwiftUI

public struct CalendarImageCardButton: View {
    private enum Constants {
        enum Sizes {
            static let cornerRadius: CGFloat = 4
            static let cardWidth: CGFloat = 48
            static let cardHeight: CGFloat = 78
            static let dateComponentHorizontalPadding: CGFloat = 18
            static let dateComponentTopPadding: CGFloat = 8
            static let dateComponentBottomPadding: CGFloat = 50
        }
        enum Colors {
            static let backgroundColor: Color = .orangeGray9
        }
    }
    
    public init(
        dateNumber: Int,
        dateType: DateNumberType,
        imageURLStrings: [String] = [],
        action: (() -> Void)? = nil
    ) {
        self.dateNumber = dateNumber
        self.dateType = dateType
        self.imageURLStrings = imageURLStrings
        self.action = action
    }
    
    public var dateNumber: Int
    public var dateType: DateNumberType
    /// 이미지 두개까지 등록 가능
    public var imageURLStrings: [String]
    public var action: (() -> Void)?
    
    private var _imageURLStrings: [String] {
        imageURLStrings.prefix(2).map({ $0 })
    }
    
    public var body: some View {
        Button {
            action?()
        } label: {
            ZStack {
                HStack(spacing: 1) {
                    ForEach(_imageURLStrings, id: \.self) { imageURLString in
                        VStack {
                            KFImage(URL(string: imageURLString))
                                .resizable()
                                .scaledToFill()
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .clipped()
                    }
                }
                .frame(maxWidth: .infinity)
                
                CalendarDateNumberView(
                    dateNumber: dateNumber,
                    dateType: dateType
                )
                .padding(.horizontal, Constants.Sizes.dateComponentHorizontalPadding)
                .padding(.top, Constants.Sizes.dateComponentTopPadding)
                .padding(.bottom, Constants.Sizes.dateComponentBottomPadding)
            }
            .frame(
                width: Constants.Sizes.cardWidth,
                height: Constants.Sizes.cardHeight,
                alignment: .center
            )
            .background(Constants.Colors.backgroundColor)
            .cornerRadius(Constants.Sizes.cornerRadius)
        }
    }
}

#if DEBUG
struct CalendarImageCardButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                CalendarImageCardButton(
                    dateNumber: 5,
                    dateType: .today,
                    imageURLStrings: ["https://i.mydramalist.com/jl6Wrc.jpg?v=1"]
                ) {
                    print("CalendarImageCardButton")
                }
                CalendarImageCardButton(
                    dateNumber: 18,
                    dateType: .hasContent,
                    imageURLStrings: [
                        "https://i.mydramalist.com/W2mRD_5c.jpg",
                        "https://i.mydramalist.com/RApq6c.jpg?v=1"
                    ]
                ) {
                    print("CalendarImageCardButton")
                }
                Spacer()
            }
            Spacer()
        }
        .frame(width: .infinity, height: .infinity)
        .background(.gray)
        .previewLayout(.sizeThatFits)
    }
}
#endif
