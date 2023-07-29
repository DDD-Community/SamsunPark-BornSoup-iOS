//
//  EventRecommendation.swift
//  DomainKit
//
//  Created by 고병학 on 2023/07/29.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct EventRecommendation: Codable, Hashable, Identifiable {
    public var id: UUID
    public var title: String
    
    public init(id: UUID, title: String) {
        self.id = id
        self.title = title
    }
}
