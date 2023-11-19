//
//  MyPageInfoResponse.swift
//  DomainKit
//
//  Created by 고병학 on 11/19/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct MyPageInfoResponseModel: BaseResponse {
    public var header: Header
    public var body: MyPageInfoBody?
}

public struct MyPageInfoBody: Hashable, Codable {
    public var email: String
    public var nickname: String
    public var statusMessage: String?
    public var interestInfos: [Int]?
    
    public init(email: String, nickname: String, statusMessage: String?, interestInfos: [Int]?) {
        self.email = email
        self.nickname = nickname
        self.statusMessage = statusMessage
        self.interestInfos = interestInfos
    }
}
