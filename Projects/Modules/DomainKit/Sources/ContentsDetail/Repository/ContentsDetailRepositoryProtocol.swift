//
//  ContentsDetailRepositoryProtocol.swift
//  DomainKit
//
//  Created by 신의연 on 11/25/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import CoreKit
import DIKit

import Foundation

public protocol ContentsDetailRepositoryProtocol {
    func requestContentsDetail(seq: String) async throws -> ContentsResponse
}
