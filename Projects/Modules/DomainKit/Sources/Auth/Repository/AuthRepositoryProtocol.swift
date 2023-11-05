//
//  AuthRepositoryProtocol.swift
//  DomainKit
//
//  Created by 고병학 on 10/8/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public protocol AuthRepositoryProtocol {
    func loginWithSocialToken(_ token: String, socialType: SocialType) async -> (LoginResponseModel?, Error?)
    func logout() async -> (Bool?, Error?)
    func refreshAccessToken() async -> (LoginResponseModel?, Error?)
    func signup(with model: SignupRequestModel) async -> (SignupResponseModel?, Error?)
    func checkNickname(_ nickname: String) async -> (SimpleYNResponse?, Error?)
    func checkEmail(_ email: String) async -> (SimpleYNResponse?, Error?)
}

public class DefaultAuthRepository: AuthRepositoryProtocol {
    public func loginWithSocialToken(_ token: String, socialType: SocialType) async -> (LoginResponseModel?, Error?) {
        return (nil, nil)
    }
    
    public func logout() async -> (Bool?, Error?) {
        return (nil, nil)
    }
    
    public func refreshAccessToken() async -> (LoginResponseModel?, Error?) {
        return (nil, nil)
    }
    
    public func signup(with model: SignupRequestModel) async -> (SignupResponseModel?, Error?) {
        return (nil, nil)
    }
    
    public func checkNickname(_ nickname: String) async -> (SimpleYNResponse?, Error?) {
        return (nil, nil)
    }
    
    public func checkEmail(_ email: String) async -> (SimpleYNResponse?, Error?) {
        return (nil, nil)
    }
    
}
