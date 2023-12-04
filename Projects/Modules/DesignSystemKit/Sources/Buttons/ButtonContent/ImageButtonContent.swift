//
//  ImageButtonContent.swift
//  DesignSystemKit
//
//  Created by 고병학 on 10/1/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public struct ImageButtonContent: View {
    public init(image: Image, action: @escaping () -> Void) {
        self.image = image
        self.action = action
    }
    
    public let image: Image
    public let action: () -> Void
    
    public var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 90, height: 90)
            .clipShape(.circle)
            .onTapGesture {
                self.action()
            }
    }
}

#if DEBUG
struct ImageButtonContent_Preview: PreviewProvider {
    static var previews: some View {
        ImageButtonContent(image: DesignSystemKitAsset.checkImagePlaceholder.swiftUIImage) {
            print("tap")
        }
    }
}
#endif
