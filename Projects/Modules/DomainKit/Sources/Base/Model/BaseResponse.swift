//
//  BaseRespnose.swift
//  DomainKit
//
//  Created by 고병학 on 10/8/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public protocol BaseResponse: Codable {
    associatedtype Body: Codable
    
    var header: Header { get }
    var body: Body? { get }
}

public struct Header: Codable {
    public let status: Int
    public let message: String
}
