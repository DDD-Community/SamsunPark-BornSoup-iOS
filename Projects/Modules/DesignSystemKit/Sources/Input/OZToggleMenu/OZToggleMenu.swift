//
//  OZToggleMenu.swift
//  DesignSystemKit
//
//  Created by 고병학 on 12/4/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public struct OZToggleMenu: View {
    
    public init(title: String, description: String, toggleOn: Binding<Bool>) {
        self.title = title
        self.description = description
        self.toggleOn = toggleOn
    }
    
    public var title: String
    public var description: String
    public var toggleOn: Binding<Bool>
    
    public var body: some View {
        Toggle(isOn: toggleOn, label: {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(Font.Body1.regular)
                    .foregroundColor(Color(red: 0.19, green: 0.18, blue: 0.16))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Text(description)
                    .font(Font.Body3.regular)
                    .foregroundColor(Color(red: 0.7, green: 0.68, blue: 0.66))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(0)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        })
        .tint(Color.main1)
        .padding(12)
        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
        .cornerRadius(10)
    }
}

#if DEBUG
struct OZToggleMenu_Previews: PreviewProvider {
    static var previews: some View {
        OZToggleMenu(
            title: "전체 공개",
            description: "리뷰에서 공개되며, 오전 마케팅 채널에서 소개될 수 있습니다",
            toggleOn: .init(get: { true }, set: { _ in })
        )
    }
}
#endif
