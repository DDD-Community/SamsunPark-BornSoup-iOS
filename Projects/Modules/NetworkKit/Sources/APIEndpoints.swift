//
//  URLs.swift
//  NetworkKit
//
//  Created by 고병학 on 10/9/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public enum APIEndpoints {
    case loginWithSocialToken
    case refreshToken
    
    case signup
    case checkIsNicknameDuplicated
    case checkIsEmailDuplicated
    case resign
    
    case fetchMyInfo
    
    public var baseURL: URL { URL(string: "https://oneul.store/")! }
    
    public var path: String {
        switch self {
        case .loginWithSocialToken: return "api/auth/signin"
        case .refreshToken: return "api/auth/reissue"
        case .resign: return "api/auth/resign"
            
        case .signup: return "signup"
        case .checkIsNicknameDuplicated: return "signup/check/nickname"
        case .checkIsEmailDuplicated: return "signup/check/email"
            
        case .fetchMyInfo: return "mypage/infos"
        }
    }
}
