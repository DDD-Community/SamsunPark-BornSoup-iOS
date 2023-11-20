//
//  ModifyProfileView.swift
//  PresentationKit
//
//  Created by 고병학 on 11/19/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

public struct ModifyProfileView: View {
    
    let store: StoreOf<ModifyProfile>
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                VStack {
                    LargeTitleNavBar(title: "프로필 편집") {
                        viewStore.send(.didTapBackButton)
                    }
                    
                    VStack(alignment: .center, spacing: 28) {
                        DesignSystemKitAsset.icDefaultProfile.swiftUIImage
                            .frame(width: 120, height: 120)
                        
                        VStack(alignment: .leading, spacing: 14) {
                            Text("닉네임")
                                .font(Font.Title2.semiBold)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.orangeGray5)
                                .padding(.horizontal, 16)
                            
                            ShortTextField(
                                title: viewStore.state.userInfo.nickname,
                                isNecessaryField: false,
                                showDownIcon: false
                            )
                        }
                    }
                    .padding(.top, 16)
                    
                    Spacer()
                    
                    HStack(alignment: .top, spacing: 16) {
                        SecondaryButton(title: "회원탈퇴") {
                            viewStore.send(.didTapResign)
                        }
                        
                        PrimaryButton(title: "로그아웃") {
                            viewStore.send(.didTapLogout)
                        }
                    }
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
                }
                .toolbar(.hidden, for: .navigationBar)
                .toolbar(.hidden, for: .tabBar)
                
                if viewStore.state.showLogoutPopup {
                    OZDialogView(title: "로그아웃 하시겠습니까?", cancelString: "취소", confirmString: "로그아웃") {
                        viewStore.send(.didTapCancelLogout)
                    } confirmAction: {
                        viewStore.send(.didTapConfirmLogout)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct ModifyProfileView_Preview: PreviewProvider {
    static var previews: some View {
        ModifyProfileView(
            store: .init(
                initialState: .init(
                    userInfo: .init(
                        email: "email",
                        nickname: "닉네임 입니다.",
                        statusMessage: "statusMessage",
                        interestInfos: [1, 2, 3]
                    )
                ),
                reducer: {
                    ModifyProfile()
                }
            )
        )
    }
}
#endif
