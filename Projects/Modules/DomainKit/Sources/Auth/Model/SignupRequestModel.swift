//
//  SignupRequestModel.swift
//  DomainKit
//
//  Created by 고병학 on 10/8/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct SignupRequestModel: Codable {
    public let nickname: String
    public let email: String
    
    /// Area 배열을 String으로 변환해서 전달
    public let interestAreas: String
    
    /// Area 배열을 String으로 변환해서 전달
    public let interestFields: String
    
    public init(nickname: String, email: String, interestAreas: String, interestFields: String) {
        self.nickname = nickname
        self.email = email
        self.interestAreas = interestAreas
        self.interestFields = interestFields
    }
}
