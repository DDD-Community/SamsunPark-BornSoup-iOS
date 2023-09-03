//
//  Array+.swift
//  CoreKit
//
//  Created by 고병학 on 2023/09/04.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}
