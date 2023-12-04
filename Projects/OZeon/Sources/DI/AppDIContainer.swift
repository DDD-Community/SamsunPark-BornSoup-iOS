//
//  AppDIContainer.swift
//  OZeon
//
//  Created by 고병학 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import DataKit
import DIKit
import DomainKit
import Swinject

import Foundation

public final class AppDIContainer {
    
    public static let shared: AppDIContainer = .init()
    
    private let diContainer: Container = DIContainer.container
    
    private init() {}
    
    public func registerDependencies() {
        registerRepositories()
        registerUseCases()
    }
    
    // MARK: - UseCases
    private func registerUseCases() {
        registerAuthUseCase()
        registerHomeUseCase()
        registerContentsDetailUseCase()
        registerMyPageUseCase()
        registerSearchUseCase()
    }
    
    private func registerAuthUseCase() {
        diContainer.register(AuthUseCaseProtocol.self) { resolver in
            AuthUseCase(repository: resolver.resolve(AuthRepositoryProtocol.self)!)
        }
    }

    private func registerHomeUseCase() {
        diContainer.register(HomeUseCaseProtocol.self) { resolver in
            HomeUseCase(repository: resolver.resolve(HomeRepositoryProtocol.self)!)
        }
    }
    
    private func registerContentsDetailUseCase() {
        diContainer.register(ContentsDetailUseCaseProtocol.self) { resolver in
            ContentsDetailUseCase(repository: resolver.resolve(ContentsDetailRepositoryProtocol.self)!)
        }
    }
    
    private func registerMyPageUseCase() {
        diContainer.register(MyPageUseCaseProtocol.self) { resolver in
            MyPageUseCase(repository: resolver.resolve(MyPageRepositoryProtocol.self)!)
        }
    }
    
    private func registerSearchUseCase() {
        diContainer.register(SearchUseCaseProtocol.self) { resolver in
            SearchUseCase(repository: resolver.resolve(SearchRepositoryProtocol.self)!)
        }
    }
    
    // MARK: - Repositories
    private func registerRepositories() {
        registerAuthRepository()
        registerHomeRepository()
        registerMyPageRepository()
        registerContentsDetailRepository()
        registerSearchRepository()
    }
    
    private func registerAuthRepository() {
        diContainer.register(AuthRepositoryProtocol.self) { _ in AuthRepository() }
    }
    
    private func registerHomeRepository() {
        diContainer.register(HomeRepositoryProtocol.self) { _ in
            HomeRepository()
        }
    }
    
    private func registerContentsDetailRepository() {
        diContainer.register(ContentsDetailRepositoryProtocol.self) { _ in
            ContentsDetailRepository()
        }
    }
    
    private func registerMyPageRepository() {
        diContainer.register(MyPageRepositoryProtocol.self) { _ in
            MyPageRepository()
        }
    }
    
    private func registerSearchRepository() {
        diContainer.register(SearchRepositoryProtocol.self) { _ in
            SearchRepository()
        }
    }
}
