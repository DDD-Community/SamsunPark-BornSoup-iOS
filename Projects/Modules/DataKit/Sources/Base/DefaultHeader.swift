//
//  DefaultHeader.swift
//  DataKit
//
//  Created by 고병학 on 10/8/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Alamofire

import Foundation

struct DefaultHeader {
    static let headers: HTTPHeaders = [
        .init(name: "Content-Type", value: "application/json")
    ]
}