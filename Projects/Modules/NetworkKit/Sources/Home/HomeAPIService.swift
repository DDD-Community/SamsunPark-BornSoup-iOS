//
//  HomeAPIService.swift
//  NetworkKit
//
//  Created by 신의연 on 11/19/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Alamofire

import Foundation

public enum HomeAPIService {
    case contentsList
}

extension HomeAPIService: TargetType {
    public var path: String {
        switch self {
        case .contentsList:
            return "/infos/all"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .contentsList:
            return .get
        }
    }
    
    public var parameters: Parameters? {
        return nil
    }
    
    public var headers: HTTPHeaders? {
        return [
            HTTPHeader.contentType("application/json"),
            HTTPHeader.acceptLanguage(Locale.current.identifier)
        ]
    }
}
