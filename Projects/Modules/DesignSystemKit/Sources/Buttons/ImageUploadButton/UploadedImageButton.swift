//
//  UploadedImageButton.swift
//  DesignSystemKit
//
//  Created by 고병학 on 2023/09/17.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Kingfisher

import SwiftUI

public struct UploadedImageButton: View {
    private enum Constants {
        enum Sizes {
            static let fullRadius: CGFloat = 100
            static let circleSize: CGSize = .init(width: 90, height: 90)
            static let xButtonSize: CGSize = .init(width: 24, height: 24)
        }
        enum Images {
            static let placeHolder: Image = DesignSystemKitAsset.checkImagePlaceholder.swiftUIImage
        }
    }
    
    public init(imageUrlString: String, action: (() -> Void)? = nil) {
        self.imageUrlString = imageUrlString
        self.action = action
    }
    
    private let imageUrlString: String
    private let action: (() -> Void)?
    private let placeholder: () -> Image = {
        Constants.Images.placeHolder
    }
    
    public var body: some View {
        HStack(spacing: -24) {
            KFImage.url(URL(string: imageUrlString))
                .resizable()
                .placeholder(placeholder)
                .aspectRatio(contentMode: .fill)
                .frame(
                    width: Constants.Sizes.circleSize.width,
                    height: Constants.Sizes.circleSize.height
                )
                .cornerRadius(Constants.Sizes.fullRadius)

            VStack {
                Spacer()
                DesignSystemKitAsset.circleXButton.swiftUIImage
                    .frame(
                        width: Constants.Sizes.xButtonSize.width,
                        height: Constants.Sizes.xButtonSize.height
                    )
                    .cornerRadius(Constants.Sizes.fullRadius)
            }
        }
        .frame(
            width: Constants.Sizes.circleSize.width,
            height: Constants.Sizes.circleSize.height
        )
        .padding(0)
        .onTapGesture {
            action?()
        }
    }
}

#if DEBUG
struct UploadedImageButton_Previews: PreviewProvider {
    static var previews: some View {
        UploadedImageButton(imageUrlString: "https://i.mydramalist.com/RApq6c.jpg?v=1") {
            print("Tapped")
        }
    }
}
#endif
