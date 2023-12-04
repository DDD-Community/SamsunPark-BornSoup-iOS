//
//  OZTextView.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/09/03.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public struct OZTextView: View {
    enum Constant {
        static let lineWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 10
        static let borderColor: Color = .orangeGray5
        static let invalidColor: Color = .error
        static var textViewHeight: CGFloat = 97
    }
    
    @Binding var text: String
    var placeholder: String
    let textLimit: Int = 2000
    
    public init(text: Binding<String>, placeholder: String = "placeholder") {
        self._text = text
        self.placeholder = placeholder
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            GeometryReader { _ in
                ZStack(alignment: .leading) {
                    TextEditor(text: $text)
                        .foregroundColor(.orangeGray1)
                        .font(.Body1.regular)
                        .scrollContentBackground(.hidden)
                        .onChange(of: text) { newValue in
                            if newValue.count > textLimit {
                                text = String(newValue.prefix(textLimit))
                            }
                        }
                    
                    if text.isEmpty {
                        VStack {
                            Text(placeholder)
                                .foregroundColor(Color.gray)
                                .font(.Body1.regular)
                                .disabled(true)
                                .allowsHitTesting(false)
                                .padding(.top, 8)
                                .padding(.leading, 4)
                            Spacer()
                        }
                    }
                }
            }
            .padding(.top, 12)
            .padding(.horizontal, 16)
            .frame(height: Constant.textViewHeight)
            
            HStack(spacing: 0) {
                Spacer()
                Text("\(text.count)")
                    .foregroundColor(text.count >= textLimit ? Constant.invalidColor : .orangeGray1)
                Text("/\(textLimit)")
                    .foregroundColor(.orangeGray5)
            }
            .font(.Body3.regular)
            .padding(.top, 5)
            .padding(.bottom, 12)
            .padding(.horizontal, 12)
        }
        .background(Color.orangeGray9)
        .overlay(
            Group {
                RoundedRectangle(cornerRadius: Constant.cornerRadius)
                    .stroke(
                        text.count >= textLimit ? Constant.invalidColor : Constant.borderColor,
                        lineWidth: Constant.lineWidth
                    )
            }
        )
    }
}

#if DEBUG
struct OZTextView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            OZTextView(
                text: .init(
                    get: { "" },
                    set: { _ in }
                ),
                placeholder: "placeholder"
            )
            .padding()
        }
    }
}
#endif
