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
        
        public init(
            name: String,
            platform: Platform,
            product: Product
        ) {
            self.name = name
            self.platform = platform
            self.product = product
        }
    }
    
    private let dependency: Dependency
    
    public init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    public func build(payload: Payload) -> [Target] {
        
        let sourceTarget = Target(
            name: payload.name,
            platform: payload.platform,
            product: payload.product,
            bundleId: payload.name,
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            scripts: [.SwiftLintString],
            dependencies: self.dependency.frameworkDependencies
        )
        
        let testTarget = Target(
            name: "\(payload.name)Tests",
            platform: payload.platform,
            product: .unitTests,
            bundleId: payload.name + "Tests",
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [
                .target(name: payload.name),
            ] + self.dependency.unitTestsDependencies
        )
        
        return [sourceTarget, testTarget]
    }
}
