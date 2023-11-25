//
//  OZDialogView.swift
//  DesignSystemKit
//
//  Created by 고병학 on 10/2/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public struct OZDialogView: View {
    public init(
        title: String,
        message: String = "",
        cancelString: String? = nil,
        confirmString: String,
        cancelAction: (() -> Void)? = {},
        confirmAction: @escaping () -> Void
    ) {
        self.content = message.isEmpty ? title : "\(title)\n\(message)"
        self.cancelString = cancelString
        self.confirmString = confirmString
        self.cancelAction = cancelAction
        self.confirmAction = confirmAction
    }
    
    let content: String
    let cancelString: String?
    let confirmString: String
    let cancelAction: (() -> Void)?
    let confirmAction: (() -> Void)?
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.7)
            VStack(alignment: .center, spacing: 30) {
                Text("\(content)")
                    .font(Font.Title2.semiBold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.orangeGray1)
                
                HStack(alignment: .top, spacing: 16) {
                    if let cancelString {
                        SecondaryButton(title: cancelString, isActivated: true) {
                            cancelAction?()
                        }
                    }
                    PrimaryButton(title: confirmString, isActivated: true) {
                        confirmAction?()
                    }
                }
                .padding(0)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 30)
            .background(Color.white)
            .cornerRadius(30)
            .padding(.horizontal, 16)
        }
    }
}

#if DEBUG
struct OZDialogView_Previews: PreviewProvider {
    static var previews: some View {
        OZDialogView(
            title: "타이틀",
            cancelString: "취소 버튼",
            confirmString: "확인 버튼"
        ) {
            print("취소 버튼")
        } confirmAction: {
            print("확인 버튼")
        }
        
    }
}
#endif
