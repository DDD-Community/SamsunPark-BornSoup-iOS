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
            VStack {
                LargeTitleNavBar(title: "프로필 편집") {
                    viewStore.send(.didTapBackButton)
                }
                
                Spacer()
                
                Text("Modify profile view")
                Text(viewStore.state.userInfo.nickname)
                
                Spacer()
            }
            .toolbar(.hidden, for: .navigationBar)
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
                        interestInfos: [1,2,3]
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
