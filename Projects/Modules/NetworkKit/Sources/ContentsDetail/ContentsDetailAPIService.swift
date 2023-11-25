//
//  ContentsDetailAPIService.swift
//  NetworkKit
//
//  Created by 신의연 on 11/25/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Alamofire

import Foundation

public enum ContentsDetailAPIService {
    case contentsDetail(String)
}

extension ContentsDetailAPIService: TargetType {
    public var path: String {
        switch self {
        case .contentsDetail:
            return "/InfoDetail"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .contentsDetail:
            return .get
        }
    }
    
    public var parameters: Parameters? {
        switch self {
        case .contentsDetail(let seq):
            let parameter: [String: Any] = [
                "seq": seq
            ]
            return parameter
        }
    }
    
    public var headers: HTTPHeaders? {
        return [
            HTTPHeader.contentType("application/json"),
            HTTPHeader.acceptLanguage(Locale.current.identifier)
        ]
    }
}
