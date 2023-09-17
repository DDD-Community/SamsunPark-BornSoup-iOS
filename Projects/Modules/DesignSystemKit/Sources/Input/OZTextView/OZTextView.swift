//
//  OZTextView.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/09/03.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

struct OZTextView: View {
    
    enum Constant {
        static let lineWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 10
        static let borderColor: Color = .orangeGray5
        static let invalidColor: Color = .error
        static var textViewHeight: CGFloat = 97
    }
    
    @Binding var text: String
    @State var placeholder: String = "placeholder"
    let textLimit: Int = 2000
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    TextEditor(text: $text)
                        .foregroundColor(.orangeGray1)
                        .font(.Body1.regular)
                        .onChange(of: text) { newValue in
                            if newValue.count > textLimit {
                                text = String(newValue.prefix(textLimit))
                            }
                        }
                    
                    if text.isEmpty {
                        TextEditor(text: $placeholder)
                            .disabled(true)
                            .foregroundColor(Color.gray)
                            .font(.Body1.regular)
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
            OZTextView(text: .constant("sample text"))
                .padding()
        }
    }
}
#endif
