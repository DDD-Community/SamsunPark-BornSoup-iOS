//
//  SignupResponseModel.swift
//  DomainKit
//
//  Created by 고병학 on 10/8/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct SignupResponseModel: BaseResponse {    
    public var header: Header
    public var body: SignupResponseBody?
    
    public init(header: Header, body: SignupResponseBody) {
        self.header = header
        self.body = body
    }
}

public struct SignupResponseBody: Codable {
    public let memberId: Int
    public let nickname: String
    public let email: String
    public let interestAreas: String
    public let interestFields: String
    
    public init(memberId: Int, nickname: String, email: String, interestAreas: String, interestFields: String) {
        self.memberId = memberId
        self.nickname = nickname
        self.email = email
        self.interestAreas = interestAreas
        self.interestFields = interestFields
    }
}
