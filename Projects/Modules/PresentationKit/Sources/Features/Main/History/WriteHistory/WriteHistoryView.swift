//
//  WriteHistoryView.swift
//  PresentationKit
//
//  Created by 고병학 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

public struct WriteHistoryView: View {
    
    public init(store: StoreOf<WriteHistory>) {
        self.store = store
    }
    
    private let store: StoreOf<WriteHistory>
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                TitleNavBar(title: "기록 작성") {
                    viewStore.send(.didTapBackButton)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    ScrollView(.horizontal) {
                        HStack(alignment: .bottom) {
                            ImageUploadButton(totalCount: 5, currentCount: 0)
                        }
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    
                    ShortTextField(title: "전통콘텐츠명", isNecessaryField: true)
                        .onTapGesture {
                            print("전통콘텐츠명")
                        }
                    
                    ScoreInputField(title: "만족도", isNecessaryField: true)
                    
                    ShortTextField(title: "날짜를 선택해주세요", isNecessaryField: true)
                        .onTapGesture {
                            print("날짜를 선택해주세요")
                        }
                    
                    ShortTextField(title: "함께한 사람이 있나요?", isNecessaryField: false)
                        .onTapGesture {
                            print("함께한 사람이 있나요?")
                        }
                    
                }
                .padding(0)
                .frame(maxWidth: .infinity)
                
                Spacer()
            }
            .navigationBarBackButtonHidden()
            .toolbar(.hidden, for: .tabBar)
        }
    }
}

#if DEBUG
struct WriteHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        WriteHistoryView(store: .init(initialState: WriteHistory.State()) {
            WriteHistory()
        })
    }
}
#endif
