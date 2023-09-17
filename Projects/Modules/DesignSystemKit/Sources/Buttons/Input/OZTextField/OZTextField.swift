//
//  OZTextField.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/09/03.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

struct OZTextFieldStyle: TextFieldStyle {
    @Binding var text: String
    @Binding var invalidation: Bool
    @FocusState private var isFocused: Bool
    
    init(
        text: Binding<String>,
        invalidation: Binding<Bool>
    ) {
        self._text = text
        self._invalidation = invalidation
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            Image.Icon.search
                .renderingMode(.template)
            
            configuration
                .focused($isFocused)
                .onTapGesture {
                    isFocused = true
                }
            Button {
                text = ""
            } label: {
                if text.count > 0 && isFocused && !invalidation {
                    Image.Icon.delete
                }
            }
        }
        .onChange(of: invalidation) { newValue in
            isFocused = false
        }
        .padding(10)
    }
}

struct OZTextField: View {
    
    let title: any StringProtocol
    @Binding var text: String
    @Binding var invalidation: Bool
    @State private var changingValue: Bool = false
    
    init(
        title: any StringProtocol,
        text: Binding<String>,
        invalidation: Binding<Bool> = .constant(true)
    ) {
        self.title = title
        self._text = text
        self._invalidation = invalidation
    }
    
    var body: some View {
        TextField(title, text: $text) { changed in
            changingValue = changed
        }
        .cornerRadius(6)
        .overlay(
            Group {
                RoundedRectangle(cornerRadius: 23)
                    .stroke(
                        invalidation ? Color.error : Color.orangeGray1,
                        lineWidth: 1
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

struct OZTextField_Previews: PreviewProvider {
    static var previews: some View {
        OZTextField(title: "플레이스 홀더", text: .constant("123"), invalidation: .constant(false))
    }
}
