//
//  ContentsModel.swift
//  DomainKit
//
//  Created by 신의연 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct ContentsModel: Codable, Hashable {
    static let mock = ContentsModel(
        id: 0,
        seq: "",
        mainImg: [
            "https://picsum.photos/160/226",
            "https://picsum.photos/160/226",
            "https://picsum.photos/160/226"
        ],
        starRating: "2023.04.13",
        mainContactPhone: "010-1234-1234",
        price: "130000",
        detailUrl: "https://naver.com",
        gpsX: "",
        gpsY: "",
        detailContent1: "https://picsum.photos/160/226",
        detailContent2: "https://picsum.photos/160/226"
    )
    
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
    
    static func from(_ response: ContentsResponse) -> ContentsModel {
        return ContentsModel(
            id: response.id,
            seq: response.seq,
            mainImg: response.mainImg,
            starRating: response.starRating,
            mainContactPhone: response.mainContactPhone,
            price: response.price,
            detailUrl: response.detailUrl,
            gpsX: response.gpsX,
            gpsY: response.gpsY,
            detailContent1: response.detailContent1,
            detailContent2: response.detailContent2
        )
    }
}
