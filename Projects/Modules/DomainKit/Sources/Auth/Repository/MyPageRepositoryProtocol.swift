//
//  MyPageRepositoryProtocol.swift
//  DomainKit
//
//  Created by 고병학 on 11/19/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public protocol MyPageRepositoryProtocol {
    func fetchMyInfo() async -> (MyPageInfoResponseModel?, Error?)
}

public struct DefaultMyPageRepository: MyPageRepositoryProtocol {
    public func fetchMyInfo() async -> (MyPageInfoResponseModel?, Error?) {
        return (nil, nil)
    }
}
