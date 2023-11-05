//
//  AuthRepositoryTest.swift
//  DataKitTests
//
//  Created by 고병학 on 10/9/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import DataKit
import DomainKit

import XCTest

final class AuthRepositoryTest: XCTestCase {
    
    private var authRepository: AuthRepositoryProtocol!

    override func setUpWithError() throws {
        authRepository = AuthRepository()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_sns_login() async {
        let (response, error) = await authRepository.loginWithSocialToken("", socialType: .APPLE)
        printResponse(response, error: error)
    }
    
    func test_refresh_token() async {
        let (response, error) = await authRepository.refreshAccessToken()
        printResponse(response, error: error)
    }
    
    private func printResponse<T: BaseResponse>(_ response: T?, error: Error?) {
        guard let response else {
            print("🚧 Error: \(error?.localizedDescription ?? "")")
            return
        }
        print("🚧 Response: \(response)")
    }
}
