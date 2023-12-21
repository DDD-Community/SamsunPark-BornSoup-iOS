//
//  UploadImageRepositoryProtocol.swift
//  DomainKit
//
//  Created by 고병학 on 12/21/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public protocol UploadImageRepositoryProtocol {
    func uploadImage(_ imageData: Data) async -> (String?, Error?)
}

public final class DefaultUploadImageRepository: UploadImageRepositoryProtocol {
    public func uploadImage(_ imageData: Data) async -> (String?, Error?) {
        return (nil, nil)
    }
}
