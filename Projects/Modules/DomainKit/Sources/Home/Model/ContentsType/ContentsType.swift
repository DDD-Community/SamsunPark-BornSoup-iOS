//
//  ContentsType.swift
//  DomainKit
//
//  Created by 신의연 on 2023/10/15.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public enum ContentsType: String, Codable, Hashable, CaseIterable {
    case review = "후기"
    case location = "위치"
    case palace = "고궁"
    case music = "국악"
    case dance = "무용"
    case craft = "공예"
    case experience = "체험관"
    case museum = "박물관"
    case artGallery = "미술관"
    
    public func convertToListTitle() -> String {
        switch self {
        case .review:
            return "가 많은 인기 콘텐츠 모음"
        case .location:
            return "에서 만날 수 있는 콘텐츠"
        case .music:
            return "의 아름다움을 \n경험할 수 있는 콘텐츠"
        case .palace:
            return "에서 \n만나는 한국의 역사 콘텐츠"
        case .experience:
            return "에서 \n경험하며 배우는 문화콘텐츠"
        case .craft:
            return "의 미와 실용성을 \n느낄 수 있는 예술 콘텐츠"
        case .dance:
            return "의 우아함을 \n느낄 수 있는 예술 콘텐츠"
        case .museum:
            return "으로 떠나는 문화여행"
        case .artGallery:
            return "에서 \n과거 예술과들의 역작 모음"
        }
    }
}
