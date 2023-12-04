//
//  WriteHistoryView.swift
//  PresentationKit
//
//  Created by 고병학 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import PhotosUI
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
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 8) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .bottom) {
                                PhotosPicker(
                                    selection: viewStore.$pickerItems,
                                    maxSelectionCount: 5,
                                    selectionBehavior: .ordered,
                                    matching: .images,
                                    photoLibrary: .shared()
                                ) {
                                    ImageUploadButton(
                                        totalCount: viewStore.totalCount,
                                        currentCount: viewStore.selectedAlbumImages.count
                                    )
                                }
                                ForEach(viewStore.selectedAlbumImages.indices, id: \.self) { index in
                                    ImageButtonContent(image: viewStore.selectedAlbumImages[index].image) {
                                        viewStore.send(.didTapImage(index))
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        }
                        
                        ShortTextField(
                            title: viewStore.selectedContents?.title ?? "전통콘텐츠명",
                            isNecessaryField: true
                        )
                        .onTapGesture {
                            viewStore.send(.didTapContent)
                        }
                        
                        ScoreInputField(title: "만족도", isNecessaryField: true)
                        
                        ShortTextField(
                            title: viewStore.showCalendarFirst ?
                            getDateString(viewStore.selectedDate)
                            : "날짜를 선택해주세요",
                            isNecessaryField: true
                        )
                        .onTapGesture {
                            viewStore.send(.didTapShowCalendar)
                        }
                        
                        if viewStore.showCalendar {
                            DatePicker(
                                "",
                                selection: viewStore.$selectedDate,
                                displayedComponents: .date
                            )
                            .labelsHidden()
                            .datePickerStyle(.graphical)
                            .frame(maxHeight: 400)
                            .onChange(of: viewStore.$selectedDate, perform: { value in
                                 print(value)
                                viewStore.send(.didTapShowCalendar)
                            })
                        }
                        
                        ShortTextField(title: "함께한 사람이 있나요?", isNecessaryField: false)
                            .onTapGesture {
                                print("함께한 사람이 있나요?")
                            }
                        
                        OZTextView(
                            text: viewStore.$reviewText,
                            placeholder: "전통콘텐츠에서 경험을 공유해주세요\n나와 다른 유저의 하루를 더 풍부하게 만들 수 있어요!"
                        )
                        .padding(.horizontal, 16)
                        
                        OZToggleMenu(
                            title: "전체 공개",
                            description: "리뷰에서 공개되며, 오전 마케팅 채널에서 소개될 수 있습니다",
                            toggleOn: viewStore.$isReviewPublic
                        )
                        .padding(.horizontal, 16)
                        .padding(.bottom, 56)
                    }
                    .padding(0)
                    .frame(maxWidth: .infinity)
                }
                
                Spacer()
                
                Text("오·전의 운영정책을 위반하는 경우에는 숨김 처리될 수 있습니다")
                    .font(Font.Body3.regular)
                    .foregroundColor(Color.orangeGray5)
                    .padding(.bottom, 8)
                
                PrimaryButton(
                    title: "다음",
                    isActivated: viewStore.state.isNextButtonActivated
                ) {
                    viewStore.send(._didTapConfirmButton)
                }
                .padding(.horizontal, 16)
            }
            .navigationBarBackButtonHidden()
            .toolbar(.hidden, for: .tabBar)
        }
        .sheet(
            store: store.scope(
                state: \.$search,
                action: WriteHistory.Action.search
            ),
            content: {
                SearchView(store: $0)
            }
        )
    }
    
    private func getDateString(_ date: Date) -> String {
        let formatter: DateFormatter = .init()
        formatter.dateFormat = "YYYY년 MM월 dd일"
        return formatter.string(from: date)
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
