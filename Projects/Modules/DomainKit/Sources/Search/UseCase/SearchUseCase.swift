//
//  SearchUseCase.swift
//  DomainKit
//
//  Created by 고병학 on 12/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import CoreKit
import DIKit

import Foundation

public protocol SearchUseCaseProtocol {
    func searchContentsWithTitle(_ title: String) async -> ContentsListResponse?
}

public struct SearchUseCase: SearchUseCaseProtocol {
    private let repository: SearchRepositoryProtocol
    
    public init(repository: SearchRepositoryProtocol) {
        self.repository = repository
    }
    
    public func searchContentsWithTitle(_ title: String) async -> ContentsListResponse? {
        return await repository.searchWithTitle(title).0
    }
}

extension SearchUseCase: DependencyKey {
    public static let liveValue: SearchUseCase = Self(repository: DIContainer.container.resolve(SearchRepositoryProtocol.self)!)
}

extension DependencyValues {
    public var searchUseCase: SearchUseCaseProtocol {
        get { self[SearchUseCase.self] }
        set { self[SearchUseCase.self] = newValue as! SearchUseCase }
    }
}
