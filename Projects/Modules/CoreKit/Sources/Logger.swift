//
//  Logger.swift
//  CoreKit
//
//  Created by 고병학 on 10/8/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Foundation

public struct Logger {
    public init() {}
    
    static public func log(_ message: String?, _ _class: String, _ _function: String) {
        #if DEBUG
        print("🚧 [LOGGER] \nTime:\(Date())")
        print("From class:\(_class), function: \(_function)")
        print("message: \(message ?? "Unknown error")")
        print("🚧 [LOGGER] END =========")
        #endif
    }
}
