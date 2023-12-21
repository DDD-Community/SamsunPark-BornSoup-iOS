//
//  FirebaseClient.swift
//  NetworkKit
//
//  Created by 고병학 on 12/21/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import CoreKit
import Firebase
import FirebaseStorage

import Foundation

public final class FirebaseClient {
    public init() {}
    
    public func uploadImage(_ imageData: Data, _ imagePath: String) async -> (String?, Error?) {
        let storageRef: StorageReference = Storage.storage().reference().child(imagePath)
        do {
            _ = try await storageRef.putDataAsync(imageData)
            let url: URL = try await storageRef.downloadURL()
            return (url.absoluteString, nil)
        } catch {
            Logger.log(error.localizedDescription, "\(Self.self)", #function)
            return (nil, NSError(domain: "failed to upload image", code: -1, userInfo: nil))
        }
    }
}
