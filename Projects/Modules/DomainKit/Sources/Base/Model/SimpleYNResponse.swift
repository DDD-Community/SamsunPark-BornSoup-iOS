//
//  SimpleYNResponse.swift
//  DomainKit
//
//  Created by 고병학 on 10/8/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct SimpleYNResponse: BaseResponse {
    public var header: Header
    public var body: YNENum
    
    public init(header: Header, body: YNENum) {
        self.header = header
        self.body = body
    }
}
