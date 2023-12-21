//
//  AlbumImage.swift
//  PresentationKit
//
//  Created by 고병학 on 12/21/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public struct AlbumImage: Transferable, Identifiable, Hashable {
    public var id: UUID = .init()
    public let image: Image
    
    public static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            guard let uiImage = UIImage(data: data) else {
                throw ImageTransferError.importFailed
            }
            let image = Image(uiImage: uiImage)
            return AlbumImage(image: image)
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
