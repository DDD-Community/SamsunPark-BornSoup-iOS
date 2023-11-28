//
//  ContentsDetailView.swift
//  PresentationKit
//
//  Created by 신의연 on 11/22/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import Kingfisher

import SwiftUI
import DomainKit
import DesignSystemKit

struct ContentsDetailView: View {
    let store: StoreOf<ContentsDetail>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                VStack(spacing: 0) {
                    VStack {
                        ZStack {
                            HStack {
                                Button {
                                    viewStore.send(.dismissButtonTapped)
                                } label: {
                                    DesignSystemKitAsset.icBack24.swiftUIImage
                                }
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text(viewStore.previewContentsData.title)
                                    .multilineTextAlignment(.center)
                                    .font(.Title2.semiBold)
                                    .foregroundColor(.orangeGray1)
                                Spacer()
                            }
                            .padding(.horizontal, 12)
                            HStack {
                                Spacer()
                                if let detailUrl = viewStore.contentsData.detailUrl {
                                    ShareLink(item: detailUrl) {
                                        DesignSystemKitAsset.icShare24.swiftUIImage
                                    }
                                } else {
                                    Button {
                                        viewStore.send(.emitErrorMessage(.homepageLinkNotFound))
                                    } label: {
                                        DesignSystemKitAsset.icShare24.swiftUIImage
                                    }
                                }
                                
                                //TODO: - 추후 딥링크 작업 예정
                                
                            }
                        }
                        .padding(.top, 17)
                        .padding(.bottom, 16)
                        .padding(.horizontal, 16)
                    }
                    
                    ScrollView {
                        VStack(spacing: 0) {
                            TabView {
                                ForEach(viewStore.previewContentsData.thumbnails, id: \.self) { url in
                                    KFImage(URL(string: url))
                                        .resizable()
                                        .scaledToFit()
                                }
                            }
                            .background(Color.black)
                            .tabViewStyle(.page)
                            .tabViewStyle(.page(indexDisplayMode: .always))
                            .frame(height: 555)
                            
                            HStack(spacing: 0) {
                                VStack(spacing: 0) {
                                    Button(action: {
                                        viewStore.send(.callButtonTapped)
                                    }, label: {
                                        DesignSystemKitAsset.icCall2pt.swiftUIImage
                                            .padding(.horizontal, 13)
                                            .padding(.vertical, 13)
                                            .background(
                                                Circle()
                                                    .foregroundColor(.main5)
                                            )
                                    })
                                    .padding(.bottom, 8)
                                    
                                    Text(Constants.phoneCall)
                                        .font(.Body2.regular)
                                        .foregroundColor(.orangeGray3)
                                }
                                
                                Spacer()
                                
                                VStack(spacing: 0) {
                                    if let detailURLString = viewStore.contentsData.detailUrl,
                                       let detailUrl = URL(string: detailURLString) {
                                        Link(destination: detailUrl) {
                                            DesignSystemKitAsset.icSite2pt.swiftUIImage
                                                .padding(.horizontal, 13)
                                                .padding(.vertical, 13)
                                                .background(
                                                    Circle()
                                                        .foregroundColor(.main5)
                                                )
                                        }
                                        .padding(.bottom, 8)
                                    } else {
                                        Button {
                                            viewStore.send(.emitErrorMessage(.homepageLinkNotFound))
                                        } label: {
                                            DesignSystemKitAsset.icSite2pt.swiftUIImage
                                                .padding(.horizontal, 13)
                                                .padding(.vertical, 13)
                                                .background(
                                                    Circle()
                                                        .foregroundColor(.main5)
                                                )
                                                .padding(.bottom, 8)
                                        }
                                    }
                                    
                                    Text(Constants.homePage)
                                        .font(.Body2.regular)
                                        .foregroundColor(.orangeGray3)
                                }
                                
                                Spacer()
                                
                                VStack(spacing: 0) {
                                    if let detailUrl = viewStore.contentsData.detailUrl {
                                        ShareLink(item: detailUrl) {
                                            DesignSystemKitAsset.icShare2pt.swiftUIImage
                                                .padding(.horizontal, 13)
                                                .padding(.vertical, 13)
                                                .background(
                                                    Circle()
                                                        .foregroundColor(.main5)
                                                )
                                        }
                                        .padding(.bottom, 8)
                                    } else {
                                        Button(action: {
                                            viewStore.send(.emitErrorMessage(.homepageLinkNotFound))  //TODO: - 추후 딥링크 작업 예정
                                        }, label: {
                                            DesignSystemKitAsset.icShare2pt.swiftUIImage
                                                .padding(.horizontal, 13)
                                                .padding(.vertical, 13)
                                                .background(
                                                    Circle()
                                                        .foregroundColor(.main5)
                                                )
                                        })
                                        .padding(.bottom, 8)
                                    }
                                    
                                    Text(Constants.share)
                                        .font(.Body2.regular)
                                        .foregroundColor(.orangeGray3)
                                }
                                
                                //TODO: - 회원 연동 안됨 좋아요 기능 추후 예정
                                //                            Spacer()
                                //                            VStack(spacing: 0) {
                                //                                Button(action: {
                                //
                                //                                }, label: {
                                //                                    DesignSystemKitAsset.icLike24Off.swiftUIImage
                                //                                        .padding(.horizontal, 13)
                                //                                        .padding(.vertical, 13)
                                //                                        .background(
                                //                                            Circle()
                                //                                                .foregroundColor(.main5)
                                //                                        )
                                //                                })
                                //                                .padding(.bottom, 8)
                                //
                                //                                Text(Constants.like)
                                //                                    .font(.Body2.regular)
                                //                                    .foregroundColor(.orangeGray3)
                                //                            }
                            }
                            .padding(.vertical, 20)
                            .padding(.horizontal, 46.5)
                        }
                        
                        Divider()
                        
                        VStack(spacing: 20) {
                            HStack(spacing: 0) {
                                DesignSystemKitAsset.icLocation2pt.swiftUIImage
                                    .renderingMode(.template)
                                    .foregroundColor(.orangeGray6)
                                    .padding(.trailing, 8)
                                Text(viewStore.contentsData.area ?? "주소 정보가 없습니다")
                                    .font(.Body1.regular)
                                    .foregroundColor(.orangeGray1)
                                
                                Spacer()
                            }
                            
                            HStack(spacing: 0) {
                                DesignSystemKitAsset.icDate2pt.swiftUIImage
                                    .renderingMode(.template)
                                    .foregroundColor(.orangeGray6)
                                    .padding(.trailing, 12)
                                Text(Constants.displaying)
                                    .font(.Body1.semiBold)
                                    .foregroundColor(.error)
                                    .padding(.trailing, 8)
                                Divider()
                                    .padding(.trailing, 8)
                                if viewStore.previewContentsData.endDate == "상시전시" {
                                    Text(viewStore.previewContentsData.endDate)
                                        .font(.Body1.regular)
                                        .foregroundColor(.orangeGray1)
                                } else {
                                    Text("\(viewStore.previewContentsData.startDate) ~ \(viewStore.previewContentsData.endDate)")
                                        .font(.Body1.regular)
                                        .foregroundColor(.orangeGray1)
                                }
                                Spacer()
                            }
                            
                            //TODO: - 영업시간 추후 작업 필요
                            //                        HStack(spacing: 6.5) {
                            //                            DesignSystemKitAsset.icTime2pt.swiftUIImage
                            //                                .renderingMode(.template)
                            //                                .foregroundColor(.orangeGray6)
                            //                            Text(viewStore.contentsData.area)
                            //                                .font(.Body1.regular)
                            //                                .foregroundColor(.orangeGray1)
                            //                            Spacer()
                            //                        }
                            
                            HStack(spacing: 0) {
                                DesignSystemKitAsset.icCall2pt.swiftUIImage
                                    .renderingMode(.template)
                                    .foregroundColor(.orangeGray6)
                                    .padding(.trailing, 12)
                                if let mainContactPhone = viewStore.contentsData.mainContactPhone, !mainContactPhone.isEmpty {
                                    Text(mainContactPhone)
                                    .font(.Body1.regular)
                                    .foregroundColor(.orangeGray1)
                                } else {
                                    Text("전화번호 정보가 없습니다")
                                        .font(.Body1.regular)
                                        .foregroundColor(.orangeGray1)
                                }
                                Spacer()
                            }
                            
                            HStack(spacing: 0) {
                                DesignSystemKitAsset.icSite2pt.swiftUIImage
                                    .renderingMode(.template)
                                    .foregroundColor(.orangeGray6)
                                    .padding(.trailing, 12)
                                if let detailUrl = viewStore.contentsData.detailUrl, !detailUrl.isEmpty {
                                    Text(detailUrl)
                                        .font(.Body1.regular)
                                        .foregroundColor(.orangeGray1)
                                } else {
                                    Text("url 정보가 없습니다")
                                        .font(.Body1.regular)
                                        .foregroundColor(.orangeGray1)
                                }
                                Spacer()
                            }
                            
                            HStack(spacing: 0) {
                                DesignSystemKitAsset.icCoin2pt.swiftUIImage
                                    .renderingMode(.template)
                                    .foregroundColor(.orangeGray6)
                                    .padding(.trailing, 12)
                                if let price = viewStore.contentsData.price, !price.isEmpty {
                                    Text(price)
                                    .font(.Body1.regular)
                                    .foregroundColor(.orangeGray1)
                                } else {
                                    Text( "가격 정보가 없습니다")
                                        .font(.Body1.regular)
                                        .foregroundColor(.orangeGray1)
                                }
                                Spacer()
                            }
                        }
                        .padding(.vertical, 30)
                        .padding(.horizontal, 16)
                        
                        Divider()
                        
                        if let reservationPeriod = viewStore.contentsData.reservationPeriod, let reservationPageName = viewStore.contentsData.reservationPageName, !reservationPeriod.isEmpty, !reservationPageName.isEmpty {
                            VStack(spacing: 0) {
                                HStack(spacing: 0) {
                                    Text(Constants.reservation)
                                        .font(.Title2.semiBold)
                                        .foregroundColor(.orangeGray5)
                                    Spacer()
                                }
                                .padding(.bottom, 30)
                                
                                HStack(spacing: 0) {
                                    DesignSystemKitAsset.icDate2pt.swiftUIImage
                                        .renderingMode(.template)
                                        .foregroundColor(.orangeGray6)
                                        .padding(.trailing, 12)
                                    
                                    Text(reservationPeriod)
                                        .font(.Body1.regular)
                                        .foregroundColor(.orangeGray1)
                                    
                                    Spacer()
                                }
                                .padding(.bottom, 20)
                                
                                HStack(spacing: 0) {
                                    DesignSystemKitAsset.icReservation2pt.swiftUIImage
                                        .renderingMode(.template)
                                        .foregroundColor(.orangeGray6)
                                        .padding(.trailing, 12)
                                    
                                    Text(reservationPageName)
                                        .font(.Body1.regular)
                                        .foregroundColor(.orangeGray1)
                                    
                                    Spacer()
                                }
                                .padding(.bottom, 20)
                                if let reservationLink = viewStore.contentsData.reservationLink, let reservationUrl = URL(string: reservationLink), !reservationLink.isEmpty, reservationLink.hasPrefix("https://") {
                                    Link(destination: reservationUrl) {
                                        PrimaryButton(title: Constants.moveToReservation) { }
                                            .disabled(true)
                                    }
                                } else {
                                    PrimaryButton(title: Constants.moveToReservation) {
                                        viewStore.send(.emitErrorMessage(.homepageLinkNotFound))
                                    }
                                }
                            }
                            .padding(.vertical, 30)
                            .padding(.horizontal, 16)
                            Divider()
                        }
                        
                        VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                Text(Constants.detailInfo)
                                    .font(.Title2.semiBold)
                                    .foregroundColor(.orangeGray5)
                                Spacer()
                            }
                            .padding(.bottom, 30)
                            
                            if let contentsImg = viewStore.contentsData.detailContentImg {
                                KFImage(URL(string: contentsImg))
                                    .resizable()
                            }
                            if let detailContents = viewStore.contentsData.detailContent1, !detailContents.isEmpty {
                                Text(detailContents)
                            }
                        }
                        .padding(.vertical, 30)
                        .padding(.horizontal, 16)
                    }
                }
                if viewStore.state.isPopupShow {
                    OZDialogView(title: "홈페이지 정보가 없습니다", confirmString: "확인") {
                        viewStore.send(.popupConfirmButtonTapped)
                    }
                    .ignoresSafeArea(edges: .all)
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            .toolbar(.hidden, for: .tabBar, .navigationBar)
        }
    }
}

#Preview {
    ContentsDetailView(
        store: Store(
            initialState: ContentsDetail.State(
                previewContentsData: .mock,
                contentsData: .mock
            ),
            reducer: {
                ContentsDetail()
            }
        )
    )
}

extension ContentsDetailView {
    enum Constants {
        static let phoneCall = "전화"
        static let homePage = "홈페이지"
        static let share = "공유"
        static let like = "좋아요"
        
        static let displaying = "진행중"
        static let reservation = "예약"
        static let moveToReservation = "예약페이지로 이동"
        
        static let detailInfo = "상제 정보"
    }
}
