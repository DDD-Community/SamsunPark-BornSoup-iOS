//
//  OZTextField.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/09/03.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public struct OZTextFieldStyle: TextFieldStyle {
    enum Constants {
        static let textFieldPadding: CGFloat = 10
    }
    
    @Binding var text: String
    @Binding var invalidation: Bool
    @FocusState private var isFocused: Bool
    
    public init(
        text: Binding<String>,
        invalidation: Binding<Bool>
    ) {
        self._text = text
        self._invalidation = invalidation
    }
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            Image.DK.icSearch16.swiftUIImage
                .renderingMode(.template)
                .foregroundColor(.orangeGray5)
            configuration
                .focused($isFocused)
                .onTapGesture {
                    isFocused = true
                }
            Button {
                text = ""
            } label: {
                if text.count > 0 && isFocused {
                    Image.DK.icSearchDelete18.swiftUIImage
                        .renderingMode(.template)
                        .foregroundColor(.orangeGray5)
                }
            }
        }
        .padding(Constants.textFieldPadding)
    }
}

public struct OZTextField: View {
    enum Constants {
        static let textFieldCornerRadius: CGFloat = 6
        static let rectangleCornerRadius: CGFloat = 23
        static let rectangleLineWidth: CGFloat = 1
    }
    
    let title: any StringProtocol
    @Binding var text: String
    @Binding var invalidation: Bool
    @State private var changingValue: Bool = false
    var onCommit: ((String) -> Void)?
    
    public init(
        title: any StringProtocol,
        text: Binding<String>,
        invalidation: Binding<Bool> = .constant(false),
        onCommit: ((String) -> Void)? = nil
    ) {
        self.title = title
        self._text = text
        self._invalidation = invalidation
        self.onCommit = onCommit
    }
    
    public var body: some View {
        TextField(title, text: $text, onCommit: {
            self.onCommit?(text)
        })
        
        /*
         { changed in
             print(changed)
             changingValue = changed
         }
         */
        .cornerRadius(Constants.textFieldCornerRadius)
        .overlay(
            Group {
                RoundedRectangle(cornerRadius: Constants.rectangleCornerRadius)
                    .stroke(
                        invalidation ? Color.error : Color.orangeGray7,
                        lineWidth: Constants.rectangleLineWidth
                    )
            }
        )
        .textFieldStyle(
            OZTextFieldStyle(
                text: $text,
                invalidation: $invalidation
            )
        )
    }
}

#if DEBUG
struct OZTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            OZTextField(title: "플레이스 홀더", text: .constant("123"), invalidation: .constant(true))
            OZTextField(title: "플레이스 홀더", text: .constant("123"), invalidation: .constant(false))
        }
    }
}
#endif
