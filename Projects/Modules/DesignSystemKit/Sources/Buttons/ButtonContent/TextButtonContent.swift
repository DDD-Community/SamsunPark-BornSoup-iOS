//
//  TextButtonContent.swift
//  DesignSystemKit
//
//  Created by 고병학 on 10/1/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct TextButtonContent {
    public init(text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    public let text: String
    public let action: () -> Void
}
