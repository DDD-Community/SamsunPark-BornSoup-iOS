//
//  OnboardingInterestedContents.swift
//  PresentationKit
//
//  Created by 고병학 on 11/11/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

public struct OnboardingInterestedContents: Reducer {
    
    public struct State: Equatable {
        public init() {}
        
        var initialContents: [CategoryModel] = [
            .init(name: "고궁", image: DesignSystemKitAsset.icOldPalace104.swiftUIImage),
            .init(name: "국악", image: DesignSystemKitAsset.icMusic104.swiftUIImage),
            .init(name: "무용", image: DesignSystemKitAsset.icDance104.swiftUIImage),
            .init(name: "공예", image: DesignSystemKitAsset.icCraft104.swiftUIImage),
            .init(name: "박물관", image: DesignSystemKitAsset.icMuseum104.swiftUIImage),
            .init(name: "미술관", image: DesignSystemKitAsset.icArtGallery104.swiftUIImage),
            .init(name: "체험관", image: DesignSystemKitAsset.icExperience104.swiftUIImage)
        ]
        var selectedContents: Set<Int> = .init()
        var isNextButtonActivated: Bool = false
        
        @PresentationState var onboardingComplete: OnboardingComplete.State?
    }
    
    public enum Action {
        case didTapConfirmButton
        case didTapBackButton
        case selectContent(Int)
        
        case onboardingComplete(PresentationAction<OnboardingComplete.Action>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapBackButton:
                return .none
                
            case .didTapConfirmButton:
                let selectedCategories: String = state.selectedContents
                    .compactMap { state.initialContents[safe: $0] }
                    .map { $0.name }
                    .joined(separator: ",")
                print(selectedCategories)
                state.onboardingComplete = .init(username: "🚧유저이름🚧")
                return .none
                
            case .selectContent(let contentIndex):
                if state.selectedContents.contains(contentIndex) {
                    state.selectedContents.remove(contentIndex)
                } else {
                    state.selectedContents.insert(contentIndex)
                }
                state.isNextButtonActivated = state.selectedContents.count > 0
                return .none
            default:
                return .none
            }
        }
        .ifLet(\.$onboardingComplete, action: /Action.onboardingComplete) {
            OnboardingComplete()
        }
    }
}

struct CategoryModel: Equatable {
    var name: String
    var image: Image
}
