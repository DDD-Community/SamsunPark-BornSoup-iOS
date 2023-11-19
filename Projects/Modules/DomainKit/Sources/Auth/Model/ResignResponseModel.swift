//
//  ResignResponseModel.swift
//  DomainKit
//
//  Created by 고병학 on 11/19/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct ResignResponseModel: BaseResponse {
    public var header: Header
    public var body: String?
}
