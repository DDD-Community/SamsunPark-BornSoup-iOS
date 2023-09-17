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
    }
    @State private var fullText: String = "1"
    @State private var placeholder: String = "d"
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .leading) {
                TextEditor(text: $fullText)
                    .foregroundColor(.orangeGray1)
                    .font(.Body1.regular)
                    .padding(.top, 12)
                    .padding(.horizontal, 16)
                if fullText.isEmpty {
                    TextEditor(text: $placeholder)
                        .disabled(true)
                        .foregroundColor(Color.gray)
                        .font(.Body1.regular)
                        .padding(.top, 12)
                        .padding(.horizontal, 16)
                }
            }
            
            HStack(spacing: 0) {
                Spacer()
                Text("\(fullText.count)")
                    .foregroundColor(.orangeGray1)
                Text("/2000")
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
                        Color.orangeGray5,
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
            OZTextView()
                .frame(height: 143)
                .padding()
            
            OZTextView()
                .frame(height: 167)
                .padding()
        }
    }
}
#endif
