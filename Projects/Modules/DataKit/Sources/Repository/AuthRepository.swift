//
//  AuthRepository.swift
//  DataKit
//
//  Created by 고병학 on 10/8/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Alamofire
import DomainKit
import NetworkKit

import Foundation

public struct AuthRepository: AuthRepositoryProtocol {
    private let baseAPIClient: BaseAPIClient = .init()
    
    public init() {} 
    
    public func loginWithSocialToken(
        _ token: String,
        socialType: SocialType
    ) async -> (LoginResponseModel?, Error?) {
        return await baseAPIClient.requestJSON(
            APIEndpoints.loginWithSocialToken.path,
            type: LoginResponseModel.self,
            method: .post,
            parameters: [
                "socialType": socialType.rawValue,
                "socialToken": token
            ],
            headers: DefaultHeader.headers
        )
    }
    
    public func logout() async -> (Bool?, Error?) {
        return (nil, nil)
    }
    
    public func refreshAccessToken() async -> (LoginResponseModel?, Error?) {
        return (nil, nil)
    }
    
    public func signup(with model: DomainKit.SignupRequestModel) async -> (SignupResponseModel?, Error?) {
        return (nil, nil)
    }
    
    public func checkNickname(_ nickname: String) async -> (SimpleYNResponse?, Error?) {
        return await baseAPIClient.requestJSON(
            APIEndpoints.checkNickname.path,
            type: SimpleYNResponse.self,
            method: .get,
            parameters: ["nickName": nickname],
            headers: DefaultHeader.headers
        )
    }
    
    public func checkEmail(_ email: String) async -> (SimpleYNResponse?, Error?) {
        return (nil, nil)
    }
}
