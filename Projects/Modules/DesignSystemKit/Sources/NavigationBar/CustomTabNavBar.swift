//
//  CustomTabNavBar.swift
//  DesignSystemKit
//
//  Created by 고병학 on 10/1/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public struct CustomTabNavBar: View {
    
    public init(
        tabButtons: [TextButtonContent],
        selectedTab: Int,
        buttons: [ImageButtonContent]
    ) {
        self.tabButtons = tabButtons
        self.selectedTab = selectedTab
        self.buttons = buttons
    }
    
    let selectedTab: Int
    let tabButtons: [TextButtonContent]
    let buttons: [ImageButtonContent]
    
    public var body: some View {
        ZStack {
            HStack(spacing: 16) {
                ForEach(Array(tabButtons.enumerated()), id: \.0) { (index, content) in
                    Text(content.text)
                        .font(
                            selectedTab == index ? .Head2.semiBold
                            : .Head2.regular
                        )
                        .foregroundColor(
                            selectedTab == index ? Color.orangeGray1
                            : Color.orangeGray5
                        )
                }
                Spacer()
            }
            HStack(spacing: 16) {
                Spacer()
                ForEach(Array(buttons.enumerated()), id: \.0) { (_, content) in
                    Button(action: content.action, label: {
                        content.image
                            .frame(width: 24, height: 24)
                    })
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 17)
        .padding(.bottom, 16)
    }
}

#if DEBUG
struct CustomTabNavBar_PreViews: PreviewProvider {
    static var previews: some View {
        CustomTabNavBar(
            tabButtons: [
                TextButtonContent(text: "최신순", action: {}),
                TextButtonContent(text: "인기순", action: {})
            ],
            selectedTab: 1,
            buttons: [
                ImageButtonContent(
                    image: Image.DK.icShare24.swiftUIImage,
                    action: {}
                ),
                ImageButtonContent(
                    image: Image.DK.icSearch24.swiftUIImage,
                    action: {}
                ),
                ImageButtonContent(
                    image: Image.DK.icFilter24.swiftUIImage,
                    action: {}
                )
            ]
        )
    
    }
}
#endif
