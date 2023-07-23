//
//  FactResponse.swift
//  DomainKit
//
//  Created by 고병학 on 2023/07/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

/// https://api.api-ninjas.com/v1/facts?limit=
struct Fact: Codable {
    var fact: String
}
