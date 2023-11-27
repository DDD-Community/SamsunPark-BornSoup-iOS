//
//  ResignView.swift
//  PresentationKit
//
//  Created by 고병학 on 11/20/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Alamofire
import ComposableArchitecture

import SwiftUI

public struct ResignView: View {
    
    public init(store: StoreOf<Resign>) {
        self.store = store
    }
    
    let store: StoreOf<Resign>
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                VStack {
                    TitleNavBar(title: "") {
                        viewStore.send(.didTapBackButton)
                    }
                    // Head-1 (28px)/SemiBold
                    Text("탈퇴하기")
                      .font(Font.Head1.semiBold)
                      .foregroundColor(Color.orangeGray1)
                      .frame(maxWidth: .infinity, alignment: .topLeading)
                      .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        // Title-1 (20px)/SemiBold/Trimmed
                        Text("처음부터 다시 가입해야 합니다")
                          .font(
                            Font.custom("Pretendard", size: 20)
                              .weight(.semibold)
                          )
                          .foregroundColor(Color(red: 0.19, green: 0.18, blue: 0.16))
                          .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        // Body-1 (16px)/Regular/Default
                        Text("탈퇴 회원의 정보는 15일간 임시 보관 후\n완벽히 삭제 됩니다.\n탈퇴하시면 회원가입부터 다시 해야해요.")
                          .font(Font.custom("Pretendard", size: 16))
                          .foregroundColor(Color(red: 0.7, green: 0.68, blue: 0.66))
                          .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding(16)
                    .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        // Title-1 (20px)/SemiBold/Trimmed
                        Text("모든 기록이 삭제 됩니다")
                          .font(
                            Font.custom("Pretendard", size: 20)
                              .weight(.semibold)
                          )
                          .foregroundColor(Color(red: 0.19, green: 0.18, blue: 0.16))
                          .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        // Body-1 (16px)/Regular/Default
                        Text("탈퇴 회원의 정보는 15일간 임시 보관 후\n완벽히 삭제 됩니다.\n탈퇴하시면 회원가입부터 다시 해야해요.")
                          .font(Font.custom("Pretendard", size: 16))
                          .foregroundColor(Color(red: 0.7, green: 0.68, blue: 0.66))
                          .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding(16)
                    .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    
                    Spacer()
                    
                    HStack(alignment: .top, spacing: 16) {
                        SecondaryButton(title: "되돌아가기") {
                            viewStore.send(.didTapBackButton)
                        }
                        
                        PrimaryButton(title: "회원 탈퇴") {
                            viewStore.send(.didTapResignButton)
                        }
                    }
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
                }
                
                if viewStore.state.showResignPopup {
                    OZDialogView(title: "탈퇴 하시겠습니까?", cancelString: "취소", confirmString: "탈퇴") {
                        viewStore.send(.didTapCancelResign)
                    } confirmAction: {
                        self.tabbedWithdrawalBtn()
                        viewStore.send(.didTapConfirmResign)
                    }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .toolbar(.hidden, for: .tabBar)
        }
    }
    
    private func tabbedWithdrawalBtn() {
        guard let clientSecret = UserDefaults.standard.string(forKey: "AppleClientSecret"),
              let refreshToken = UserDefaults.standard.string(forKey: "AppleRefreshToken") else {
//            self.store.send(.didTapBackButton)
            return
        }
        print("Client_Secret - \(clientSecret)")
        print("refresh_token - \(refreshToken)")
        self.revokeAppleToken(clientSecret: clientSecret, token: refreshToken) {
            self.store.send(.didCompletedAppleResigning)
        }
    }
}

struct AppleTokenResponse: Codable {
    var access_token: String?
    var token_type: String?
    var expires_in: Int?
    var refresh_token: String?
    var id_token: String?
}

extension ResignView {
    func revokeAppleToken(clientSecret: String, token: String, completionHandler: @escaping () -> Void) {
        let bundleID = "kr.ddd.ozeon.OZeon"
        let url = "https://appleid.apple.com/auth/revoke?client_id=\(bundleID)&client_secret=\(clientSecret)&token=\(token)&token_type_hint=refresh_token"
        let header: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]

        AF.request(url,
                   method: .post,
                   headers: header)
        .validate(statusCode: 200..<600)
        .responseData { response in
            guard let statusCode = response.response?.statusCode else { return }
            if statusCode == 200 {
                print("애플 토큰 삭제 성공!")
                completionHandler()
            }
        }
    }
}

#if DEBUG
struct ResignView_Previews: PreviewProvider {
    static var previews: some View {
        ResignView(store: .init(initialState: Resign.State()) {
            Resign()
        })
    }
}
#endif
