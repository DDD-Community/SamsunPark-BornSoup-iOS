//
//  CuratingModel.swift
//  DomainKit
//
//  Created by 신의연 on 2023/10/15.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct CuratingModel: Codable, Equatable, Identifiable {
    public var id = UUID()
    public var category: String
    public var title: String
    public var location: String
    public var date: String
}
