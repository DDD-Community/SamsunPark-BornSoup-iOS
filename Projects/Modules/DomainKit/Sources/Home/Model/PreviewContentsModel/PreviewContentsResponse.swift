//
//  PreviewContentsResponse.swift
//  DomainKit
//
//  Created by 신의연 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct PreviewContentsResponse: Codable, Equatable {
    public let id: Int
    public let seq: String
    public let title: String
    public let thumbnail: [String]
    public let startDate: String
    public let endDate: String
    public let category: String
    public let area: String
    public let place: String
    public let ttInfoDetail: ContentsResponse
    
    enum PreviewContentsCodingKeys: String, CodingKey {
        case id
        case seq
        case title
        case thumbnail
        case startDate
        case endDate
        case category
        case area
        case place
        case ttInfoDetail
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PreviewContentsCodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.seq = try container.decode(String.self, forKey: .seq)
        self.title = try container.decode(String.self, forKey: .title)
        self.thumbnail = try container.decode([String].self, forKey: .thumbnail)
        self.startDate = try container.decode(String.self, forKey: .startDate)
        self.endDate = try container.decode(String.self, forKey: .endDate)
        self.category = try container.decode(String.self, forKey: .category)
        self.area = try container.decode(String.self, forKey: .area)
        self.place = try container.decode(String.self, forKey: .place)
        self.ttInfoDetail = try container.decode(ContentsResponse.self, forKey: .ttInfoDetail)
    }
}
