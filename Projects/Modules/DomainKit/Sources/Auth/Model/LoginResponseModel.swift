//
//  LoginResponse.swift
//  DomainKit
//
//  Created by 고병학 on 10/8/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct LoginResponseModel: BaseResponse {
    public var header: Header
    public var body: LoginResponseBody?
}

public struct LoginResponseBody: Codable {
    public var accessToken: String
    public var grantType: String
    public var expiresIn: Int
    public var memberId: Int
    public var isSignUp: Bool
}
