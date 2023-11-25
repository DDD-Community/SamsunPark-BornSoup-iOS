//
//  ContentsDetailUseCase.swift
//  DomainKit
//
//  Created by 신의연 on 11/25/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import CoreKit
import DIKit

import Foundation

public protocol ContentsDetailUseCaseProtocol {
    func requestContentsDetail(seq: String) async throws -> ContentsResponse
}

public struct ContentsDetailUseCase: ContentsDetailUseCaseProtocol {
    private let repository: ContentsDetailRepositoryProtocol
    
    public init(repository: ContentsDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    public func requestContentsDetail(seq: String) async throws -> ContentsResponse {
        return try await repository.requestContentsDetail(seq: seq)
    }
}

extension ContentsDetailUseCase: DependencyKey {
    public static let liveValue: ContentsDetailUseCase = Self(repository: DIContainer.container.resolve(ContentsDetailRepositoryProtocol.self)!)
}

extension DependencyValues {
    public var contentsDetailUseCase: ContentsDetailUseCase {
        get { self[ContentsDetailUseCase.self] }
        set { self[ContentsDetailUseCase.self] = newValue }
    }
}
