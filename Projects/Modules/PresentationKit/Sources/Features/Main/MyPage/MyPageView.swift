//
//  MyPageView.swift
//  PresentationKit
//
//  Created by 고병학 on 11/19/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

public struct MyPageView: View {
    
    let store: StoreOf<MyPage>
    
    public var body: some View {
        NavigationStackStore(
            self.store.scope(state: \.path, action: { .path($0) })
        ) {
            WithViewStore(store, observe: { $0 }) { viewStore in
                VStack {
                    LargeTitleNavBar(title: "내 정보", isBackButtonEnabled: false)
                        .padding(.bottom, 32)
                    HStack(alignment: .center) {
                        // Space Between
                        HStack(alignment: .center, spacing: 8) {
                            Image("")
                                .frame(width: 69, height: 69)
                                .background(Color(red: 1, green: 0.84, blue: 0.25).opacity(0.3))
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(viewStore.state.userInfo?.nickname ?? "")
                                    .font(Font.Title1.semiBold)
                                    .foregroundColor(Color(red: 1, green: 0.56, blue: 0)) + Text("님")
                                    .font(Font.Title1.semiBold)
                                    .foregroundColor(Color.orangeGray1)
                                
                                //                            HStack(alignment: .center, spacing: 4) {
                                //                                DesignSystemKitAsset.icInsta24.swiftUIImage
                                //                                    .frame(width: 24, height: 24)
                                //
                                //                                Text("insta_ID_placeholder")
                                //                                    .font(Font.Body1.regular)
                                //                                    .foregroundColor(Color.orangeGray5)
                                //                            }
                            }
                        }
                        
                        Spacer()
                        
                        DesignSystemKitAsset.icSetting24.swiftUIImage
                            .renderingMode(.template)
                            .foregroundStyle(Color.orangeGray6)
                            .frame(width: 24, height: 24)
                            .onTapGesture {
                                viewStore.send(.didTapModifyProfileButton)
                            }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 30)
                    .background(.white)
                    
                    Spacer()
                }
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        } destination: { (state: MyPage.Path.State) in
            switch state {
            case .modifyProfile:
                CaseLet(
                    /MyPage.Path.State.modifyProfile,
                     action: MyPage.Path.Action.modifyProfile,
                     then: ModifyProfileView.init(store:)
                )
            }
        }
    }
}

#if DEBUG
struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView(store: .init(initialState: MyPage.State(), reducer: {
            MyPage()
        }))
    }
}
#endif
