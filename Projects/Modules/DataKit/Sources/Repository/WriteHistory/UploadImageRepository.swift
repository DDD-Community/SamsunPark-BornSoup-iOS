//
//  UploadImageRepository.swift
//  DataKit
//
//  Created by 고병학 on 12/21/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import CoreKit
import DomainKit
import NetworkKit

import Foundation

public struct UploadImageRepository: UploadImageRepositoryProtocol {
    private let firebaseClient: FirebaseClient = .init()
    
    public init() {}
    
    public func uploadImage(_ imageData: Data) async -> (String?, Error?) {
        let uuid: String = UUID().uuidString
        let dateFormatter: DateFormatter = .init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString: String = dateFormatter.string(from: .init())
        let imagePath: String = "images/\(dateString)/\(uuid)"
        return await firebaseClient.uploadImage(imageData, imagePath)
    }
}
