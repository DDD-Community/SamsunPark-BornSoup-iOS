//
//  OnboardingInterestedPlace.swift
//  PresentationKit
//
//  Created by 고병학 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import CoreKit

import Foundation

public struct OnboardingInterestedPlace: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init(email: String, nickname: String) {
            self.email = email
            self.nickname = nickname
        }
        
        let email: String
        let nickname: String
        
        let initialPlaces: [String] = [
            "전체",
            "강남구",
            "강동구",
            "강북구",
            "강서구",
            "관악구",
            "광진구",
            "구로구",
            "금천구",
            "노원구",
            "도봉구",
            "동대문구",
            "동작구",
            "마포구",
            "서대문구",
            "서초구",
            "성동구",
            "성북구",
            "송파구",
            "양천구",
            "영등포구",
            "용산구",
            "은평구",
            "종로구",
            "중구",
            "중랑구"
        ]
        var selectedPlaceIndices: Set<Int> = .init()
        
        var isNextButtonActivated: Bool = false
    }
    
    public enum Action: Equatable {
        case didTapBackButton
        case _didTapConfirmButton
        case didTapConfirmButton(String, String, String)
        
        case selectPlace(Int)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapBackButton:
                return .none
                
            case ._didTapConfirmButton:
                let selectedPlaces = state.selectedPlaceIndices.filter({ $0 != 0 })
                let places: String = selectedPlaces
                    .map { state.initialPlaces[$0] }
                    .joined(separator: ",")
                return .send(.didTapConfirmButton(state.email, state.nickname, places))
                
            case .selectPlace(let index):
                let placeCount = state.initialPlaces.count
                var newSelected = state.selectedPlaceIndices
                newSelected.remove(0)
                if index == 0 {
                    if newSelected.count < placeCount - 1 {
                        newSelected = Set(0..<state.initialPlaces.count)
                    } else {
                        newSelected = []
                    }
                } else {
                    if newSelected.contains(index) {
                        newSelected.remove(index)
                    } else {
                        newSelected.insert(index)
                    }
                }
                state.isNextButtonActivated = newSelected.count > 0
                if newSelected.count == placeCount - 1 {
                    newSelected.insert(0)
                }
                state.selectedPlaceIndices = newSelected
                return .none
                
            default:
                return .none
            }
        }
    }
    
}
