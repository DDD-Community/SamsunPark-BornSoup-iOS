//
//  MyPageUseCase.swift
//  DomainKit
//
//  Created by 고병학 on 11/19/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import CoreKit
import DIKit

import Foundation

public protocol MyPageUseCaseProtocol {
    func fetchMyInfo() async -> (MyPageInfoBody?, Error?)
}

public struct MyPageUseCase: MyPageUseCaseProtocol {
    private let repository: MyPageRepositoryProtocol
    
    public init(repository: MyPageRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchMyInfo() async -> (MyPageInfoBody?, Error?) {
        let (response, error): (MyPageInfoResponseModel?, Error?) = await repository.fetchMyInfo()
        if response?.body == nil {
            Logger.log(response?.body.debugDescription, "\(Self.self)", #function)
        }
        return (response?.body, error)
    }
}

extension MyPageUseCase: DependencyKey {
    public static let liveValue: MyPageUseCase = {
        let myPageRepository = DIContainer.container.resolve(MyPageRepositoryProtocol.self) ?? DefaultMyPageRepository()
        return MyPageUseCase(repository: myPageRepository)
    }()
}

extension DependencyValues {
    public var myPageUseCase: MyPageUseCaseProtocol {
        get { self[MyPageUseCase.self] }
        set { self[MyPageUseCase.self] = newValue as! MyPageUseCase }
    }
}
