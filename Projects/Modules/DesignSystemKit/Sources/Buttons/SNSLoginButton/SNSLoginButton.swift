//
//  SNSLoginButton.swift
//  DesignSystemKit
//
//  Created by 고병학 on 10/1/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import DomainKit

import SwiftUI

fileprivate enum Constants {
    enum Sizes {
        static let snsLoginLogoSize: CGFloat = 18.0
        static let snsLoginHorizontalSpace: CGFloat = 10.0
        static let signInLabelVerticalPadding: CGFloat = 16.0
        static let buttonCornerRadius: CGFloat = 100.0
    }
}

extension SNSType {    
    var buttonString: String {
        switch self {
        case .KAKAO:
            return "카카오로 로그인"
        case .APPLE:
            return "Apple로 로그인"
        }
    }
    
    var buttonBackgroundColor: Color {
        switch self {
        case .KAKAO:
            return  Color(red: 1, green: 0.9, blue: 0)
        case .APPLE:
            return Color.black
        }
    }
    
    var buttonForegroundColor: Color {
        switch self {
        case .KAKAO:
            return  .orangeGray1
        case .APPLE:
            return .ozWhite
        }
    }
    
    var buttonImage: Image {
        switch self {
        case .KAKAO:
            return Image.DK.icKakaoLogin.swiftUIImage
        case .APPLE:
            return Image.DK.icAppleLogin.swiftUIImage
        }
    }
}

public struct SNSLoginButton: View {
    public init(snsType: SNSType, action: @escaping () -> Void) {
        self.snsType = snsType
        self.action = action
    }
    
    let snsType: SNSType
    let action: () -> Void
    
    public var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack(alignment: .center, spacing: Constants.Sizes.snsLoginHorizontalSpace) {
                snsType.buttonImage
                    .frame(
                        width: Constants.Sizes.snsLoginLogoSize,
                        height: Constants.Sizes.snsLoginLogoSize
                    )
                Text(snsType.buttonString)
                    .font(.Title2.semiBold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(snsType.buttonForegroundColor)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, Constants.Sizes.signInLabelVerticalPadding)
            .background(snsType.buttonBackgroundColor)
            .cornerRadius(Constants.Sizes.buttonCornerRadius)
        })
    }
}
