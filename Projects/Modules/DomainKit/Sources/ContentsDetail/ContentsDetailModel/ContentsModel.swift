//
//  ContentsModel.swift
//  DomainKit
//
//  Created by 신의연 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct ContentsModel: Codable, Hashable {
    public static let mock = ContentsModel(
        area: "서울시",
        mainContactPhone: "02-313-4121",
        price: "3000",
        detailUrl: "www.naver.com",
        detailContent1: "www.naver.com",
        detailContentImg: "https://picsum.photos/400/600",
        reservationPeriod: "4.11(1차) 5.19(2차)",
        reservationPageName: "인터파크",
        reservationLink: "www.naver.com"
    )
    
    public var area: String?
    public var mainContactPhone: String?
    public var price: String?
    public var detailUrl: String?
    public var detailContent1: String?
    public var detailContentImg: String?
    public var reservationPeriod: String?
    public var reservationPageName: String?
    public var reservationLink: String?
    
    public static func from(_ response: ContentsResponseBody) -> ContentsModel {
        return ContentsModel(
            area: response.area,
            mainContactPhone: response.mainContactPhone,
            price: response.price,
            detailUrl: response.detailUrl,
            detailContent1: response.detailContent1,
            detailContentImg: response.detailContentImg,
            reservationPeriod: response.reservationPeriod,
            reservationPageName: response.reservationPageName,
            reservationLink: response.reservationLink
        )
    }
}
