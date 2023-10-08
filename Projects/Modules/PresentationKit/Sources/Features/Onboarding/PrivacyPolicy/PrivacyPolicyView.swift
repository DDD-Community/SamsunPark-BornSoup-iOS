//
//  PrivacyPolicyView.swift
//  PresentationKit
//
//  Created by 고병학 on 10/1/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

public struct PrivacyPolicyView: View {
    
    public init(store: StoreOf<PrivacyPolicy>) {
        self.store = store
    }
    
    let store: StoreOf<PrivacyPolicy>
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(alignment: .center, spacing: 0) {
                PaginationNavBar(
                    title: "회원가입",
                    numberOfPages: 3,
                    currentPage: 0
                ) {
                    viewStore.send(.didTapBackButton)
                }
                VStack(alignment: .center, spacing: 0) {
                    Text("약관에 동의해주세요")
                        .font(.Head2.semiBold)
                        .foregroundColor(Color.orangeGray1)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.bottom, 16)
                        .padding(.top, 28)
                    
                    Text("여러분의 개인정보와 서비스 이용 관리 \n잘 지켜드릴게요.")
                        .font(.Title2.regular)
                        .foregroundColor(Color.orangeGray4)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.bottom, 40)
                    
                    HStack(alignment: .top, spacing: 14) {
                        Button(action: {
                            viewStore.send(.didTapAgreeAllPolicy)
                        }, label: {
                            (viewStore.isAllAgreed ?
                             Image.DK.imgBadgeCheck22On.swiftUIImage
                             : Image.DK.imgBadgeCheck22Off.swiftUIImage)
                            .frame(width: 24, height: 24)
                        })
                        .padding(.top, 4)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("모두 동의")
                                .font(.Title1.semiBold)
                                .foregroundColor(Color.orangeGray1)
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                            
                            Text("서비스 이용을 위해 아래 약관에 모두 동의합니다.")
                                .font(Font.Body1.regular)
                                .foregroundColor(Color.orangeGray4)
                        }
                        .padding(0)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding(.horizontal, 0)
                    .padding(.top, 0)
                    
                    Divider()
                        .frame(height: 1)
                        .foregroundStyle(Color.orangeGray7)
                        .padding(.vertical, 20)
                    
                    HStack(alignment: .center) {
                        HStack(alignment: .center, spacing: 14) {
                            Button(action: {
                                viewStore.send(.didTapAgreeServicePolicy)
                            }, label: {
                                (viewStore.isServicePolicyAgreed ?
                                 Image.DK.imgBadgeCheck22On.swiftUIImage
                                 : Image.DK.imgBadgeCheck22Off.swiftUIImage)
                                .frame(width: 22, height: 22)
                            })
                            
                            Text("(필수) 서비스 이용 약관 동의")
                                .font(.Title2.regular)
                                .foregroundColor(Color.orangeGray4)
                        }
                        .padding(0)
                        Spacer()
                        Button(action: {
                            viewStore.send(.didTapServicePolicyDetail)
                        }, label: {
                            Text("전체보기")
                                .font(.Body1.regular)
                                .foregroundColor(Color.orangeGray6)
                        })
                    }
                    .padding(0)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 18)
                    
                    HStack(alignment: .center) {
                        HStack(alignment: .center, spacing: 14) {
                            Button(action: {
                                viewStore.send(.didTapAgreePrivacyPolicy)
                            }, label: {
                                (viewStore.isPrivacyPolicyAgreed ?
                                 Image.DK.imgBadgeCheck22On.swiftUIImage
                                 : Image.DK.imgBadgeCheck22Off.swiftUIImage)
                                .frame(width: 22, height: 22)
                            })
                            
                            Text("(필수) 개인정보 처리 방침 동의")
                                .font(.Title2.regular)
                                .foregroundColor(Color.orangeGray4)
                        }
                        .padding(0)
                        Spacer()
                        Button(action: {
                            viewStore.send(.didTapPrivacyPolicyDetail)
                        }, label: {
                            Text("전체보기")
                                .font(.Body1.regular)
                                .foregroundColor(Color.orangeGray6)
                        })
                    }
                    .padding(0)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                    
                    PrimaryButton(
                        title: "확인",
                        isActivated: viewStore.isConfirmButtonActivated
                    ) {
                        viewStore.send(.didTapConfirmButton)
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationBarBackButtonHidden()
            .navigationDestination(
                store: store.scope(
                    state: \.$ozWeb,
                    action: PrivacyPolicy.Action.ozWeb
                )
            ) {
                OZWebView(store: $0)
            }
            .navigationDestination(
                store: store.scope(
                    state: \.$onboardingNickname,
                    action: PrivacyPolicy.Action.onboardingNickname
                )
            ) {
                OnboardingNicknameView(store: $0)
            }
        }
    }
}

#if DEBUG
struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView(store: .init(initialState: PrivacyPolicy.State()) {
            PrivacyPolicy()
        })
    }
}
#endif
