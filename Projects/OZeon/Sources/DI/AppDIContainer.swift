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
        registerMyPageUseCase()
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
    
    private func registerMyPageUseCase() {
        diContainer.register(MyPageUseCaseProtocol.self) { resolver in
            MyPageUseCase(repository: resolver.resolve(MyPageRepositoryProtocol.self)!)
        }
    }
    
    // MARK: - Repositories
    private func registerRepositories() {
        registerAuthRepository()
        registerHomeRepository()
        registerMyPageRepository()
    }
    
    private func registerAuthRepository() {
        diContainer.register(AuthRepositoryProtocol.self) { _ in AuthRepository() }
    }
    
    private func registerHomeRepository() {
        diContainer.register(HomeRepositoryProtocol.self) { _ in
            HomeRepository()
        }
    }
    
    private func registerMyPageRepository() {
        diContainer.register(MyPageRepositoryProtocol.self) { _ in
            MyPageRepository()
        }
    }
}
