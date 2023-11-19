//
//  MyPageRepository.swift
//  DataKit
//
//  Created by 고병학 on 11/19/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Alamofire
import DomainKit
import NetworkKit

import Foundation

public struct MyPageRepository: MyPageRepositoryProtocol {
    private let baseAPIClient: BaseAPIClient = .init()
    
    public init() {}
    
    public func fetchMyInfo() async -> (MyPageInfoResponseModel?, Error?) {
        return await baseAPIClient.requestJSON(
            APIEndpoints.fetchMyInfo.path,
            type: MyPageInfoResponseModel.self,
            method: .get,
            headers: DefaultHeader.headers
        )
    }
}
