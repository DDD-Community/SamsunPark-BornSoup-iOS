//
//  Framework.swift
//  ProjectDescriptionHelpers
//
//  Created by 고병학 on 2023/01/25.
//

import ProjectDescription

public struct FrameworkFactory {
    
    public struct Dependency {
        
        let frameworkDependencies: [TargetDependency]
        let unitTestsDependencies: [TargetDependency]
        
        public init(
            frameworkDependencies: [TargetDependency],
            unitTestsDependencies: [TargetDependency]
        ) {
            self.frameworkDependencies = frameworkDependencies
            self.unitTestsDependencies = unitTestsDependencies
        }
    }
    
    public struct Payload {
        
        let name: String
        let platform: Platform
        let product: Product
        let infoPlist: [String: InfoPlist.Value]
        
        public init(
            name: String,
            platform: Platform,
            product: Product,
            infoPlist: [String: InfoPlist.Value] = [:]
        ) {
            self.name = name
            self.platform = platform
            self.product = product
            self.infoPlist = infoPlist
        }
    }
    
    private let dependency: Dependency
    
    public init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    public func build(payload: Payload) -> [Target] {
        let setting: SettingsDictionary = ["OTHER_LDFLAGS" : "$(inherited) -ObjC -all_load"]
        
        let sourceTarget = Target(
            name: payload.name,
            platform: payload.platform,
            product: payload.product,
            bundleId: payload.name,
            deploymentTarget: deploymentTarget,
            infoPlist: .extendingDefault(with: payload.infoPlist),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            scripts: [.SwiftLintString],
            dependencies: self.dependency.frameworkDependencies,
            settings: .settings(base: setting, defaultSettings: .recommended)
        )
        
        let testTarget = Target(
            name: "\(payload.name)Tests",
            platform: payload.platform,
            product: .unitTests,
            bundleId: payload.name + "Tests",
            deploymentTarget: deploymentTarget,
            infoPlist: .extendingDefault(with: payload.infoPlist),
            sources: ["Tests/**"],
            resources: [],
            dependencies: [
                .target(name: payload.name),
            ] + self.dependency.unitTestsDependencies
        )
        
        return [sourceTarget, testTarget]
    }
}
