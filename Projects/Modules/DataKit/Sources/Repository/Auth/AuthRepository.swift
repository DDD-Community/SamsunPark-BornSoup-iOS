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
        _ accessToken: String,
        _ idToken: String,
        socialType: SocialType
    ) async -> (LoginResponseModel?, Error?) {
        return await baseAPIClient.requestJSON(
            APIEndpoints.loginWithSocialToken.path,
            type: LoginResponseModel.self,
            method: .post,
            parameters: [
                "socialType": socialType.rawValue,
                "socialToken": accessToken,
                "idToken": idToken
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
    
    public func signup(with model: SignupRequestModel) async -> (SignupResponseModel?, Error?) {
        return await baseAPIClient.requestJSON(
            APIEndpoints.signup.path,
            type: SignupResponseModel.self,
            method: .post,
            parameters: [
                "email": model.email,
                "nickname": model.nickname,
                "interestAreas": model.interestAreas,
                "interestFields": model.interestFields
            ],
            headers: DefaultHeader.headers
        )
    }
    
    public func checkIsNicknameDuplicated(_ nickname: String) async -> (SimpleYNResponse?, Error?) {
        return await baseAPIClient.requestJSON(
            APIEndpoints.checkIsNicknameDuplicated.path,
            type: SimpleYNResponse.self,
            method: .get,
            parameters: ["nickName": nickname],
            headers: DefaultHeader.headers
        )
    }
    
    public func checkIsEmailDuplicated(_ email: String) async -> (SimpleYNResponse?, Error?) {
        return await baseAPIClient.requestJSON(
            APIEndpoints.checkIsEmailDuplicated.path,
            type: SimpleYNResponse.self,
            method: .get,
            parameters: ["email": email],
            headers: DefaultHeader.headers
        )
    }
    
    public func resign() async -> (ResignResponseModel?, Error?) {
        return await baseAPIClient.requestJSON(
            APIEndpoints.resign.path,
            type: ResignResponseModel.self,
            method: .post,
            headers: DefaultHeader.headers
        )
    }
}
