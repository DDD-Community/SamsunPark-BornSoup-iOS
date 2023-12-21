//
//  UploadImageUseCase.swift
//  DomainKit
//
//  Created by 고병학 on 12/21/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import DIKit

import Foundation

public protocol UploadImageUseCaseProtocol {
    /// 이미지 업로드 후 접속 가능한 URL 반환
    /// - Parameter imageData: 이미지 데이터
    /// - Returns:  접속 가능한 URL, 에러
    func uploadImage(_ imageData: Data) async -> (String?, Error?)
}

public class UploadImageUseCase: UploadImageUseCaseProtocol {
    private let repository: UploadImageRepositoryProtocol
    
    public init(repository: UploadImageRepositoryProtocol) {
        self.repository = repository
    }
    
    public func uploadImage(_ imageData: Data) async -> (String?, Error?) {
        return await repository.uploadImage(imageData)
    }
}

extension UploadImageUseCase: DependencyKey {
    public static let liveValue: UploadImageUseCase = UploadImageUseCase(
        repository: DIContainer.container.resolve(UploadImageRepositoryProtocol.self)
        ?? DefaultUploadImageRepository()
    )
}

extension DependencyValues {
    public var uploadImageUseCase: UploadImageUseCaseProtocol {
        get { self[UploadImageUseCase.self] }
        set { self[UploadImageUseCase.self] = newValue as! UploadImageUseCase }
    }
}
