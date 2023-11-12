//
//  EmailKeyboardModifier.swift
//  PresentationKit
//
//  Created by 고병학 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

struct EmailKeyboardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.keyboardType(.emailAddress)
    }
}
