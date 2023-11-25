//
//  ContentsDetail.swift
//  PresentationKit
//
//  Created by 신의연 on 11/22/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import UIKit
import SwiftUI
import DomainKit

public struct ContentsDetail: Reducer {
    public enum ErrorMessage: String {
        case phoneNumberNotFound = "번호를 찾을 수 없습니다"
        case homepageLinkNotFound = "홈페이지 정보가 없습니다"
    }
    public struct State: Equatable {
        var previewContentsData: PreviewContentsModel
        var contentsData: ContentsModel
        var isPopupShow: Bool = false
        var errorMessage: String = ""
        
        public init(
            previewContentsData: PreviewContentsModel, 
            contentsData: ContentsModel
        ) {
            self.previewContentsData = previewContentsData
            self.contentsData = contentsData
        }
    }
    
    public  enum Action: Equatable {
        case onAppear
        
        case dismissButtonTapped
        case shareButtonTapped
        case callButtonTapped
        case websiteButtonTapped
        case moveToReservationPageTapped
        case popupConfirmButtonTapped
        
        case requestContentsDetailData
        case contentsResponse(TaskResult<ContentsResponse>)
        
        case emitErrorMessage(ErrorMessage)
    }
    
    @Dependency(\.contentsDetailUseCase) var contentsDetailUseCase
    @Dependency(\.dismiss) var dismiss
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.requestContentsDetailData)
                
            case .dismissButtonTapped:
                return .run { send in
                    await self.dismiss()
                }
            case .shareButtonTapped:
                return .none
                
            case .callButtonTapped:
                guard let phoneNumber = state.contentsData.mainContactPhone else {
                    return .send(.emitErrorMessage(.phoneNumberNotFound))
                }
                let telephone = "tel://\(phoneNumber)"
                guard let url = URL(string: telephone), UIApplication.shared.canOpenURL(url as URL) else { return .none }
                UIApplication.shared.open(url)
                return .none
                
            case .websiteButtonTapped:
                return .none
                
            case .moveToReservationPageTapped:
                return .none
                
            case .popupConfirmButtonTapped:
                state.isPopupShow = false
                return .none
                
            case .requestContentsDetailData:
                return requestContents(seq: String("\(state.previewContentsData.id)"))
                
            case .contentsResponse(let result):
                switch result {
                case .success(let contentsResponse):
                    print(contentsResponse)
                    state.contentsData = ContentsModel.from(contentsResponse.body)
                    return .none
                case .failure(let error):
                    Logger.log(error.localizedDescription, "\(Self.self)", #function)
                    return .none
                }
                
            case .emitErrorMessage(let errorMessage):
                state.isPopupShow = true
                state.errorMessage = errorMessage.rawValue
                return .none
            }
        }
    }
    
    private func requestContents(seq: String) -> Effect<ContentsDetail.Action> {
        return .run { send in
            await send(.contentsResponse(TaskResult {
                try await contentsDetailUseCase.requestContentsDetail(seq: seq)
            }))
        }
    }
}
