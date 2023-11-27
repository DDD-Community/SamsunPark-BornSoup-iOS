//
//  PreviewContentsModel.swift
//  DomainKit
//
//  Created by 신의연 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct PreviewContentsModel: Codable, Hashable {
    public static let mock = PreviewContentsModel(
        id: 0,
        seq: 0,
        title: "한양여성 문 밖을 나서다보다 긴 제목은 어떻게 나오나요 일단 trim 처리",
        thumbnails: ["https://picsum.photos/400/555", "https://picsum.photos/400/555", "https://picsum.photos/400/555"],
        startDate: "2023.04.13",
        endDate: "2023.06.04",
        category: ContentsType.palace,
        city: "서울",
        town: "종로구"
    )
    
    public static let mock1 = PreviewContentsModel(
        id: 0,
        seq: 0,
        title: "한양여성 문 밖을 나서다",
        thumbnails: ["https://picsum.photos/160/226"],
        startDate: "2023.04.13",
        endDate: "2023.06.04",
        category: ContentsType.palace,
        city: "서울",
        town: "종로구"
    )
    
    public let id: Int
    public let seq: Int?
    public let title: String
    public let thumbnails: [String]
    public let startDate: String
    public let endDate: String
    public let category: ContentsType
    public let city: String?
    public let town: String?
    
    public static func from(_ response: PreviewContentsResponse) -> PreviewContentsModel {
        return PreviewContentsModel(
            id: response.id,
            seq: response.seq,
            title: response.title,
            thumbnails: response.thumbnails,
            startDate: OZDateFormatter.convertStringToDateString(date: response.startDate) ?? "",
            endDate: response.endDate == "99999999" ? "상시전시" :
                "\(String(describing: OZDateFormatter.convertStringToDateString(date: response.startDate)?.split(separator: " ")[1] ?? "")) \(String(describing: OZDateFormatter.convertStringToDateString(date: response.startDate)?.split(separator: " ")[2] ?? ""))",
            category: ContentsType(rawValue: response.category) ?? .etc,
            city: response.city,
            town: response.town
        )
    }
}
