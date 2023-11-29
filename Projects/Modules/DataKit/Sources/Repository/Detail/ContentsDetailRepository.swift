//
//  ContentsDetailRepository.swift
//  DataKit
//
//  Created by 신의연 on 11/25/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Alamofire
import ComposableArchitecture
import DomainKit
import NetworkKit

import Foundation

public struct ContentsDetailRepository: ContentsDetailRepositoryProtocol {
    private let baseAPIClient: BaseAPIClient = .init()
    
    public init() {}
    
    public func requestContentsDetail(seq: String) async throws -> ContentsResponse {
        let request = try ContentsDetailAPIService.contentsDetail(seq).asQueryURLRequest()
        request.log()
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(ContentsResponse.self, from: data)
        } catch let error {
            throw error
        }
    }
}
