//
//  LoginRequest.swift
//  DomainKit
//
//  Created by 고병학 on 10/9/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct LoginRequestModel: Codable {
    public var snsType: String
    public var snsToken: String
    
    public init(snsType: String, snsToken: String) {
        self.snsType = snsType
        self.snsToken = snsToken
    }
}
