//
//  SearchRepository.swift
//  DataKit
//
//  Created by 고병학 on 12/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import DomainKit
import NetworkKit

import Foundation

public struct SearchRepository: SearchRepositoryProtocol {
    private let baseAPIClient: BaseAPIClient = .init()
    
    public init() {}
    
    public func searchWithTitle(_ title: String) async -> (ContentsListResponse?, Error?) {
        return await baseAPIClient.requestJSON(
            APIEndpoints.searchWithTitle.path,
            type: ContentsListResponse.self,
            method: .get,
            parameters: ["title": title],
            headers: DefaultHeader.headers
        )
    }
}
