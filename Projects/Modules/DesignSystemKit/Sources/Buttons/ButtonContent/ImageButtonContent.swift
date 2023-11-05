//
//  ImageButtonContent.swift
//  DesignSystemKit
//
//  Created by 고병학 on 10/1/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public struct ImageButtonContent {
    public init(image: Image, action: @escaping () -> Void) {
        self.image = image
        self.action = action
    }
    
    public let image: Image
    public let action: () -> Void
}
