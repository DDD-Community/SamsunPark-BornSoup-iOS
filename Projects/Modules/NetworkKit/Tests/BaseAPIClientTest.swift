//
//  BaseAPIClientTest.swift
//  NetworkKitTests
//
//  Created by 고병학 on 2023/07/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation
import XCTest

import NetworkKit

class BaseAPIClientTest: XCTestCase {
    func test_request() async throws {
        let expectation = XCTestExpectation()
        let apiClient: BaseAPIClient = .init()
        let testBundle = Bundle(for: BaseAPIClientTest.self)
        let testFactAPIKey: String = testBundle.object(forInfoDictionaryKey: "TEST_FACT_API_KEY") as? String ?? "없음"
        let (response, error): ([Fact]?, Error?) = try await apiClient.requestJSON(
            "https://api.api-ninjas.com/v1/facts",
            type: [Fact].self,
            method: .get,
            parameters: ["limit": 10],
            headers: ["X-Api-Key": testFactAPIKey]
        )
        print("🚧 testFactAPIKey: \(testFactAPIKey)")
        if let error {
            print(error)
            XCTAssert(false)
        } else if let response {
            response.forEach {
                print("👉 \($0.fact)")
            }
        }
        expectation.fulfill()
    }
}
