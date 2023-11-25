//
//  ContentsResponse.swift
//  DomainKit
//
//  Created by 신의연 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct ContentsResponse: Codable, Equatable {
    public let header: Header
    public var body: ContentsResponseBody
}

public struct ContentsResponseBody: Codable, Equatable {
    public let area: String
    public let mainContactPhone: String
    public let price: String
    public let detailUrl: String
    public let detailContent1: String
    public let detailContentImg: String
    public let reservationPeriod: String
    public let reservationPageName: String
    public let reservationLink: String

    enum ContentsCodingKeys: String, CodingKey {
        case area
        case mainContactPhone
        case price
        case detailUrl
        case detailContent1Phone
        case detailContentImg
        case reservationPeriod
        case reservationPageName
        case reservationLink
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.area = try container.decode(String.self, forKey: .area)
        self.mainContactPhone = try container.decode(String.self, forKey: .mainContactPhone)
        self.price = try container.decode(String.self, forKey: .price)
        self.detailUrl = try container.decode(String.self, forKey: .detailUrl)
        self.detailContent1 = try container.decode(String.self, forKey: .detailContent1)
        self.detailContentImg = try container.decode(String.self, forKey: .detailContentImg)
        self.reservationPeriod = try container.decode(String.self, forKey: .reservationPeriod)
        self.reservationPageName = try container.decode(String.self, forKey: .reservationPageName)
        self.reservationLink = try container.decode(String.self, forKey: .reservationLink)
    }
}
