//
//  ContentsResponse.swift
//  DomainKit
//
//  Created by 신의연 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct ContentsResponse: Codable, Equatable {
    public let id: Int
    public let seq: String
    public let mainImg: [String]
    public let starRating: String
    public let mainContactPhone: String
    public let price: String
    public let detailUrl: String
    public let gpsX: String
    public let gpsY: String
    public let detailContent1: String
    public let detailContent2: String
    
    enum ContentsCodingKeys: String, CodingKey {
        case id
        case seq
        case mainImg
        case starRating
        case mainContactPhone
        case price
        case detailUrl
        case gpsX
        case gpsY
        case detailContent1
        case detailContent2
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ContentsCodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.seq = try container.decode(String.self, forKey: .seq)
        self.mainImg = try container.decode([String].self, forKey: .mainImg)
        self.starRating = try container.decode(String.self, forKey: .starRating)
        self.mainContactPhone = try container.decode(String.self, forKey: .mainContactPhone)
        self.price = try container.decode(String.self, forKey: .price)
        self.detailUrl = try container.decode(String.self, forKey: .detailUrl)
        self.gpsX = try container.decode(String.self, forKey: .gpsX)
        self.gpsY = try container.decode(String.self, forKey: .gpsY)
        self.detailContent1 = try container.decode(String.self, forKey: .detailContent1)
        self.detailContent2 = try container.decode(String.self, forKey: .detailContent2)
    }
}
