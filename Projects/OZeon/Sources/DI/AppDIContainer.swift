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
    }
    
    private func registerAuthUseCase() {
        diContainer.register(AuthUseCaseProtocol.self) { resolver in
            AuthUseCase(repository: resolver.resolve(AuthRepositoryProtocol.self)!)
        }
    }
    
    // MARK: - Repositories
    private func registerRepositories() {
        registerAuthRepository()
    }
    
    private func registerAuthRepository() {
        diContainer.register(AuthRepositoryProtocol.self) { _ in AuthRepository() }
    }
}
