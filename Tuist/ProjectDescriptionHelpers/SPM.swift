//
//  SPM.swift
//  Config
//
//  Created by 고병학 on 2023/01/25.
//

import ProjectDescription

extension TargetDependency {
    public struct SPM {}
}

public extension TargetDependency.SPM {
    static let TCA = Self.external("ComposableArchitecture")
    static let Kingfisher = Self.external("Kingfisher")
    static let Alamofire = Self.external("Alamofire")
    static let Swinject = Self.external("Swinject")
    
    private static func external(_ name: String) -> TargetDependency {
        return TargetDependency.external(name: name)
    }
    
    private static func package(product: String) -> TargetDependency {
        return TargetDependency.package(product: product)
    }
}
