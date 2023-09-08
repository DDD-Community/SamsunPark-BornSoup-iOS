//
//  LineButton.swift
//  PresentationKit
//
//  Created by 고병학 on 2023/09/03.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public struct LineButton: View {
    private enum Constants {
        enum Sizes {
            static let fullRadius: CGFloat = 100
            static let horizontalPadding: CGFloat = 24
            static let verticalPadding: CGFloat = 16
            static let iconWidth: CGFloat = 16
            static let iconHeight: CGFloat = 16
            static let hStackSpacing: CGFloat = 4
        }
        enum Colors {
            enum Activated {
                static let foregroundColor: Color = .main1
            }
            enum Deactivated {
                static let foregroundColor: Color = .orangeGray5
            }
            static let backgroundColor: Color = .white
        }
    }
    
    public init(
        title: String = "Button",
        image: Image? = nil,
        isActivated: Bool = true,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.image = image
        self.isActivated = isActivated
        self.action = action
    }
    
    public var title: String
    public var image: Image?
    public var isActivated: Bool
    public var action: (() -> Void)?
    
    private var foregroundColor: Color {
        isActivated ?
        Constants.Colors.Activated.foregroundColor
        : Constants.Colors.Deactivated.foregroundColor
    }
    
    public var body: some View {
        Button {
            action?()
        } label: {
            HStack(alignment: .center, spacing: Constants.Sizes.hStackSpacing) {
                image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Constants.Sizes.iconWidth, height: Constants.Sizes.iconHeight)
                
                Text(title)
                    .font(.Body1.semiBold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(foregroundColor)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, Constants.Sizes.horizontalPadding)
        .padding(.vertical, Constants.Sizes.verticalPadding)
        .cornerRadius(Constants.Sizes.fullRadius)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.Sizes.fullRadius)
                .stroke(foregroundColor, lineWidth: 1)
        )
        .disabled(!isActivated)
    }
}

#if DEBUG
struct LineButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LineButton(title: "버튼", image: Image(systemName: "mappin")) {
                print("LineButton")
            }
            LineButton(title: "버튼", image: Image(systemName: "mappin"), isActivated: false) {
                print("LineButton")
            }
        }
    }
}
#endif
