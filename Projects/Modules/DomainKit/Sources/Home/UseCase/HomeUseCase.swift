//
//  HomeUseCase.swift
//  DomainKit
//
//  Created by 신의연 on 11/19/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import CoreKit
import DIKit

import Foundation

public protocol HomeUseCaseProtocol {
    func requestContentsList() async throws -> ContentsListResponse
}

public struct HomeUseCase: HomeUseCaseProtocol {
    private let repository: HomeRepositoryProtocol
    
    public init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    public func requestContentsList() async throws -> ContentsListResponse {
        return try await repository.requestContentsList()
    }
}

extension HomeUseCase: DependencyKey {
    public static let liveValue: HomeUseCase = Self(repository: DIContainer.container.resolve(HomeRepositoryProtocol.self)!)
}

extension DependencyValues {
    public var homeUseCase: HomeUseCaseProtocol {
        get { self[HomeUseCase.self] }
        set { self[HomeUseCase.self] = newValue as! HomeUseCase }
    }
}
