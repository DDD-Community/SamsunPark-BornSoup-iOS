//
//  ChipButton.swift
//  DesignSystemKit
//
//  Created by 고병학 on 11/11/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public struct ChipButton: View {
    
    public init(
        text: String,
        leadingImage: Image? = nil,
        trailingImage: Image? = nil,
        isSelected: Bool
    ) {
        self.text = text
        self.leadingImage = leadingImage
        self.trailingImage = trailingImage
        self.isSelected = isSelected
    }
    
    private var text: String
    private var leadingImage: Image?
    private var trailingImage: Image?
    private var isSelected: Bool
    
    public var body: some View {
        HStack {
            leadingImage?.frame(width: 16, height: 16)
            Text(text)
                .foregroundStyle(isSelected ? Color.white : Color.orangeGray5)
                .font(.Body1.regular)
            trailingImage?.frame(width: 16, height: 16)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(isSelected ? Color.main1 : Color.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    isSelected ? Color.main1 : Color.orangeGray4,
                    lineWidth: 1
                )
        )
    }
}

#if DEBUG
struct ChipButton_Previews: PreviewProvider {
    static var previews: some View {
        ChipButton(text: "전체", isSelected: false)
    }
}
#endif
