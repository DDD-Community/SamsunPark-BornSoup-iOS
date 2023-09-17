//
//  ImageUploadButton.swift
//  DesignSystemKit
//
//  Created by 고병학 on 2023/09/16.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public struct ImageUploadButton: View {
    private enum Constants {
        enum Sizes {
            static let fullRadius: CGFloat = 100
            static let circleSize: CGSize = .init(width: 90, height: 90)
            static let imageSize: CGSize = .init(width: 24, height: 24)
        }
    }
    
    public init(totalCount: Int, currentCount: Int) {
        self.totalCount = totalCount
        self.currentCount = currentCount
    }
    
    private let totalCount: Int
    private var currentCount: Int
    
    private var textColor: Color {
        totalCount == currentCount ? .main1 : .orangeGray5
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            DesignSystemKitAsset.blankImage.swiftUIImage
                .frame(
                    width: Constants.Sizes.imageSize.width,
                    height: Constants.Sizes.imageSize.height
                )
            Text("\(currentCount)/\(totalCount)")
                .font(.Body1.regular)
                .foregroundColor(textColor)
        }
        .padding(0)
        .frame(
            width: Constants.Sizes.circleSize.width,
            height: Constants.Sizes.circleSize.height,
            alignment: .center
        )
        .background(Color.orangeGray9)
        .cornerRadius(Constants.Sizes.fullRadius)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.Sizes.fullRadius)
                .inset(by: 0.5)
                .stroke(Color.orangeGray8, lineWidth: 1)
        )
    }
}

#if DEBUG
public struct ImageUploadButtonWrapperView: View {
    var totalCount: Int = 5
    @State var currentCount: Int = 0
    
    public var body: some View {
        VStack {
            ImageUploadButton(
                totalCount: totalCount,
                currentCount: currentCount
            )
            HStack {
                Button("-1") {
                    guard 0 < currentCount else { return }
                    currentCount -= 1
                }
                .buttonStyle(.bordered)
                
                Button("+1") {
                    guard currentCount < totalCount else { return }
                    currentCount += 1
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

struct ImageUploadButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ImageUploadButtonWrapperView()
        }
    }
}
#endif
