//
//  AuthUseCase.swift
//  DomainKit
//
//  Created by 고병학 on 10/15/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import CoreKit
import DIKit

import Foundation

public protocol AuthUseCaseProtocol {
    func loginWithSNSToken(_ token: String, socialType: SocialType) async -> (String?, Error?)
}

public final class AuthUseCase: AuthUseCaseProtocol {
    private let repository: AuthRepositoryProtocol
    
    public init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    public func loginWithSNSToken(
        _ token: String,
        socialType: SocialType
    ) async -> (String?, Error?) {
        let (response, error): (LoginResponseModel?, Error?) = await repository.loginWithSocialToken(
            token,
            socialType: socialType
        )
        if response?.body == nil {
            Logger.log(response?.body.debugDescription)
        }
        return (response?.body?.accessToken, error)
    }
}

extension AuthUseCase: DependencyKey {
    public static let liveValue: AuthUseCase = {
        let authRepository: AuthRepositoryProtocol = DIContainer.container.resolve(AuthRepositoryProtocol.self)!
        return AuthUseCase(repository: authRepository)
    }()
}

extension DependencyValues {
    public var authUseCase: AuthUseCaseProtocol {
        get { self[AuthUseCase.self] }
        set { self[AuthUseCase.self] = newValue as! AuthUseCase }
    }
}
