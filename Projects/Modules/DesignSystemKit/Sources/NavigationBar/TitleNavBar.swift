//
//  TitleNavBar.swift
//  DesignSystemKit
//
//  Created by 고병학 on 10/1/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public struct TitleNavBar: View {
    public init(
        title: String,
        rightButtons: [ImageButtonContent] = [],
        backButtonAction: @escaping () -> Void
    ) {
        self.title = title
        self.backButtonAction = backButtonAction
        self.rightButtons = rightButtons
    }
    
    let title: String
    let backButtonAction: () -> Void
    let rightButtons: [ImageButtonContent]
    
    public var body: some View {
        ZStack {
            HStack {
                Button(action: backButtonAction, label: {
                    DesignSystemKitAsset.icBack24.swiftUIImage
                        .frame(width: 24, height: 24)
                })
                Spacer()
            }
            HStack(spacing: 16) {
                Spacer()
                ForEach(Array(rightButtons.enumerated()), id: \.0) { (_, content) in
                    Button(action: content.action, label: {
                        content.image
                            .frame(width: 24, height: 24)
                    })
                }
            }
            
            Text(title)
                .font(.Title2.semiBold)
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
struct TitleNavBar_Previews: PreviewProvider {
    static var previews: some View {
        TitleNavBar(
            title: "추천",
            rightButtons: [
                .init(image: DesignSystemKitAsset.icSearch24.swiftUIImage, action: {})
            ],
            backButtonAction: {}
        )
    }
}
#endif
