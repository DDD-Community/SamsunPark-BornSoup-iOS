//
//  WirteHistory.swift
//  PresentationKit
//
//  Created by 고병학 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import CoreKit
import CoreTransferable
import PhotosUI
import SwiftUI

public struct WriteHistory: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
        
        var isNextButtonActivated: Bool = false
        var totalCount: Int = 5
        var selectedAlbumImages: [AlbumImage] = []
        var selectedContents: PreviewContentsModel?
        var showCalendarFirst: Bool = false
        var showCalendar: Bool = false
        
        @BindingState var reviewText: String = ""
        @BindingState var isReviewPublic: Bool = false
        @BindingState var pickerItems: [PhotosPickerItem] = []
        @BindingState var selectedDate: Date = .init()
        
        @PresentationState var search: Search.State?
    }
    
    public enum Action: BindableAction, Equatable {
        case _didTapConfirmButton
        case didTapConfirmButton
        case didTapBackButton
        case didTapShowCalendar
        case insertAlbumImage(Int, AlbumImage)
        case didTapImage(Int)
        case didTapContent
        
        case binding(BindingAction<State>)
        
        case search(PresentationAction<Search.Action>)
    }
    
    @Dependency(\.dismiss) var dismiss
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case ._didTapConfirmButton:
                return .none
                
            case .didTapConfirmButton:
                return .none
                
            case .didTapBackButton:
                return .run { _ async in
                    await self.dismiss()
                }
                
            case .didTapShowCalendar:
                state.showCalendarFirst = true
                state.showCalendar.toggle()
                return .none
                
            case .insertAlbumImage(let offset, let albumImage):
                state.selectedAlbumImages[offset] = albumImage
                return .none
                
            case .didTapImage(let offset):
                state.selectedAlbumImages.remove(at: offset)
                return .none
                
            case .didTapContent:
                state.search = .init(
                    text: "",
                    recentSearches: [],
                    searchResultList: .init(contentsList: []),
                    isBackButtonHidden: true
                )
                return .none
                
            case .search(let action):
                switch action {
                case .presented(.searchResultList(.cellTapped)):
                    print("전시 선택된")
                    return .none
                case .dismiss:
                    state.selectedContents = state.search?.selectedModel
                    state.search = nil
                    return .none
                default:
                    return .none
                }
                
            case .binding(\.$pickerItems):
                state.selectedAlbumImages = .init()
                state.pickerItems.forEach { _ in
                    state.selectedAlbumImages.append(
                        .init(image: DesignSystemKitAsset.checkImagePlaceholder.swiftUIImage)
                    )
                }
                let pickerItems = state.pickerItems
                return .run { [pickerItems] send async in
                    for item in pickerItems.enumerated() {
                        guard let albumImage = await self.loadTransferable(from: item.element) else { continue }
                        await send(.insertAlbumImage(item.offset, albumImage))
                    }
                }
                
            case .binding:
                return .none
            }
        }
        .ifLet(\.$search, action: /Action.search) {
            Search()
        }
    }
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) async -> AlbumImage? {
        return try? await imageSelection.loadTransferable(type: AlbumImage.self)
    }
}
