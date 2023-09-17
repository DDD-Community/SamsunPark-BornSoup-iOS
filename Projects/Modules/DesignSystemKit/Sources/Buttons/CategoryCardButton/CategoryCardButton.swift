//
//  CategoryCardButton.swift
//  PresentationKit
//
//  Created by 고병학 on 2023/09/03.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public struct CategoryCardButton: View {
    private enum Constants {
        enum Sizes {
            static let zStackSpacing: CGFloat = 12
            static let fullRadius: CGFloat = 100
            static let imageWidth: CGFloat = 104
            static let imageHeight: CGFloat = 104
        }
        enum Colors {
            static let foregroundColor: Color = .orangeGray1
        }
        enum Images {
            static let selectedImage: Image = DesignSystemKitAsset
                .categoryCardButtonSelected
                .swiftUIImage
        }
    }
    
    public init(
        title: String = "Button",
        image: Image? = nil,
        isSelected: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.image = image
        self.isSelected = isSelected
        self.action = action
    }
    
    public var title: String
    public var image: Image?
    public var isSelected: Bool
    public var action: (() -> Void)?
    
    public var body: some View {
        Button {
            action?()
        } label: {
            VStack(alignment: .center, spacing: Constants.Sizes.zStackSpacing) {
                ZStack {
                    image?.resizable()
                    if isSelected {
                        Constants.Images.selectedImage.resizable()
                    }
                }
                .frame(width: Constants.Sizes.imageWidth, height: Constants.Sizes.imageHeight)
                .cornerRadius(Constants.Sizes.fullRadius)
                Text(title)
                    .font(.Body1.regular)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Constants.Colors.foregroundColor)
            }
            .padding(0)
        }
    }
}

#if DEBUG
struct CategoryCardButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CategoryCardButton(image: Image(systemName: "square.and.arrow.up.circle.fill"))
            CategoryCardButton(
                image: Image(systemName: "square.and.arrow.up.circle.fill"),
                isSelected: true
            )
        }
    }
}
#endif
