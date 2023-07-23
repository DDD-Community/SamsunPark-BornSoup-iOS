//
//  TabbarMenu.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/07/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public enum TabbarMenu {
    case main
    case washList
    case my
    
    func getTitle() -> String {
        switch self {
        case .main:
            return "main"
        case .washList:
            return "washHistory"
        case .my:
            return "my"
        }
    }
}
