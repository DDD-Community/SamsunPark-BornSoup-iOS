//
//  SecondaryButton.swift
//  PresentationKit
//
//  Created by 고병학 on 2023/09/03.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public struct SecondaryButton: View {
    private enum Constants {
        enum Sizes {
            static let fullRadius: CGFloat = 100
            static let horizontalPadding: CGFloat = 24
            static let verticalPadding: CGFloat = 16
        
        }
        enum Colors {
            enum Activated {
                static let foregroundColor: Color = Color(red: 0.7, green: 0.68, blue: 0.66)
                static let backgroundColor: Color = Color(red: 0.95, green: 0.93, blue: 0.91)
            }
            enum Deactivated {
                static let foregroundColor: Color = Color(red: 0.19, green: 0.18, blue: 0.16)
                static let backgroundColor: Color = Color(red: 0.98, green: 0.97, blue: 0.95)
            }
        }
    }
    
    public init(
        title: String = "Button",
        isActivated: Bool = true,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.isActivated = isActivated
        self.action = action
    }
    
    public var title: String
    public var isActivated: Bool
    public var action: (() -> Void)?
    
    public var body: some View {
        Button {
            action?()
        } label: {
            Text(title)
                .font(
                    Font.custom("Pretendard", size: 18)
                        .weight(.semibold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(
                    isActivated ?
                    Constants.Colors.Activated.foregroundColor
                    : Constants.Colors.Deactivated.foregroundColor
                )
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.horizontal, Constants.Sizes.horizontalPadding)
                .padding(.vertical, Constants.Sizes.verticalPadding)
                .background(
                    isActivated ?
                    Constants.Colors.Activated.backgroundColor
                    : Constants.Colors.Deactivated.backgroundColor
                )
                .cornerRadius(Constants.Sizes.fullRadius)
        }
        .disabled(!isActivated)
    }
}

#if DEBUG
struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SecondaryButton(title: "버튼") {
                print("SecondaryButton")
            }
            SecondaryButton(title: "버튼", isActivated: false) {
                print("SecondaryButton")
            }
        }
    }
}
#endif
