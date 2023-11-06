//
//  PreviewContentsModel.swift
//  DomainKit
//
//  Created by 신의연 on 11/5/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct PreviewContentsModel: Codable, Equatable {
    public static let mock = PreviewContentsModel(
        id: 0,
        seq: "",
        title:  "한양여성 문 밖을 나서다보다 긴 제목은 어떻게 나오나요 일단 trim 처리",
        thumbnail: ["https://picsum.photos/160/226"],
        startDate: "2023.04.13",
        endDate: "2023.06.04",
        category: ContentsType.palace,
        area: "서울",
        place: "종로구",
        contentsDetail: ContentsModel.mock
    )
    
    public static let mock1 = PreviewContentsModel(
        id: 0,
        seq: "",
        title:  "한양여성 문 밖을 나서다",
        thumbnail: ["https://picsum.photos/160/226"],
        startDate: "2023.04.13",
        endDate: "2023.06.04",
        category: ContentsType.palace,
        area: "서울",
        place: "종로구",
        contentsDetail: ContentsModel.mock
    )
    
    public let id: Int
    public let seq: String
    public let title: String
    public let thumbnail: [String]
    public let startDate: String
    public let endDate: String
    public let category: ContentsType
    public let area: String
    public let place: String
    public let contentsDetail: ContentsModel
    
    static func from(_ response: PreviewContentsResponse) -> PreviewContentsModel {
        return PreviewContentsModel(
            id: response.id,
            seq: response.seq,
            title: response.title,
            thumbnail: response.thumbnail,
            startDate: response.startDate,
            endDate: response.endDate,
            category: ContentsType(rawValue: response.category) ?? .review,
            area: response.area,
            place: response.place,
            contentsDetail: ContentsModel.from(response.ttInfoDetail)
        )
    }
}

