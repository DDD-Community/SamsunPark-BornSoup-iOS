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
        
        @BindingState var reviewText: String = ""
        @BindingState var isReviewPublic: Bool = false
        @BindingState var pickerItems: [PhotosPickerItem] = []
        var selectedAlbumImages: [AlbumImage] = []
    }
    
    public enum Action: BindableAction, Equatable {
        case _didTapConfirmButton
        case didTapConfirmButton
        case didTapBackButton
        case insertAlbumImage(Int, AlbumImage)
        
        case binding(BindingAction<State>)
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
                
            case .insertAlbumImage(let offset, let albumImage):
                state.selectedAlbumImages[offset] = albumImage
                return .none
                
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
    }
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) async -> AlbumImage? {
        return try? await imageSelection.loadTransferable(type: AlbumImage.self)
//        return imageSelection.loadTransferable(type: AlbumImage.self) { result in
//            DispatchQueue.main.async {
//                guard imageSelection == self.imageSelection else {
//                    print("Failed to get the selected item.")
//                    return
//                }
//                switch result {
//                case .success(let albumImage?):
//                    self.imageState = .success(albumImage.image)
//                case .success(nil):
//                    self.imageState = .empty
//                case .failure(let error):
//                    self.imageState = .failure(error)
//                }
//            }
//        }
    }
}

public struct AlbumImage: Transferable, Identifiable, Hashable {
    public var id: UUID = .init()
    public let image: Image
    
    public static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            guard let uiImage = UIImage(data: data) else {
                throw TransferError.importFailed
            }
            let image = Image(uiImage: uiImage)
            return AlbumImage(image: image)
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

public enum ImageState {
    case empty
    case loading(Progress)
    case success(Image)
    case failure(Error)
}

public enum TransferError: Error {
    case importFailed
}
