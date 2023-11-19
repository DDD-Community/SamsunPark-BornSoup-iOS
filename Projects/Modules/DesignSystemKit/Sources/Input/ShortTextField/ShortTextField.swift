//
//  ShortTextField.swift
//  DesignSystemKit
//
//  Created by 고병학 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public struct ShortTextField: View {
    public init(title: String, isNecessaryField: Bool) {
        self.title = title
        self.isNecessaryField = isNecessaryField
    }
    
    private let title: String
    private let isNecessaryField: Bool
    
    public var body: some View {
        HStack(alignment: .center, spacing: 12) {
            HStack(alignment: .center, spacing: 0) {
                if isNecessaryField {
                    Text(title)
                        .font(Font.Body1.regular)
                        .foregroundColor(Color.orangeGray1)
                    + Text("*")
                        .font(Font.Body1.regular)
                        .foregroundColor(Color.red)
                } else {
                    Text(title)
                        .font(Font.Body1.regular)
                        .foregroundColor(Color.orangeGray1)
                }
            }
            .padding(0)
            
            Spacer()
            
            DesignSystemKitAsset.icCaredown22.swiftUIImage
                .frame(width: 22, height: 22)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.orangeGray9)
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
}

#if DEBUG
struct ShortTextField_Previews: PreviewProvider {
    static var previews: some View {
        ShortTextField(title: "필드 이름", isNecessaryField: true)
    }
}
#endif
