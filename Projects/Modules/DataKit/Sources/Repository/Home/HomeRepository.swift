//
//  HomeRepository.swift
//  DataKit
//
//  Created by 신의연 on 11/19/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Alamofire
import DomainKit
import NetworkKit
import ComposableArchitecture

import Foundation

public struct HomeRepository: HomeRepositoryProtocol {
    
    private let baseAPIClient: BaseAPIClient = .init()
    
    public init() {}
    
    public func requestContentsList() async throws -> DomainKit.ContentsListResponse {
        let request = try HomeAPIService.contentsList.asQueryURLRequest()
        request.log()
        let (data, response) = try await URLSession.shared.data(for: request)
        //TODO: - response error 처리
        print(String(data: data, encoding: .utf8))
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(ContentsListResponse.self, from: data)
        } catch let error {
            throw error
        }
    }
    
    public func requestContentsList(page: Int, size: Int) async throws -> ContentsListResponse? {
        return nil
    }
    
    public func requestContentsListOrderByReviewCount() async throws -> ContentsListResponse? {
        return nil
    }
}
