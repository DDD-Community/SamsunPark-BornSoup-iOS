//
//  HomeRepositoryProtocol.swift
//  DomainKit
//
//  Created by 신의연 on 11/19/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import Foundation

public protocol HomeRepositoryProtocol {
    func requestContentsList() async throws -> ContentsListResponse
    func requestContentsList(page: Int, size: Int) async throws -> ContentsListResponse?
    func requestContentsListOrderByReviewCount() async throws -> ContentsListResponse?
}

