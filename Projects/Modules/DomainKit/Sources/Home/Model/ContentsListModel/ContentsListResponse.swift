//
//  ContentsListResponse.swift
//  DomainKit
//
//  Created by 신의연 on 11/19/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct ContentsListResponse: BaseResponse, Equatable {
    public let header: Header
    public let body: ContentsListResponseBody?
}

public struct ContentsListResponseBody: Codable, Equatable {
    public let infos: [PreviewContentsResponse]
    public let size: Int
}
