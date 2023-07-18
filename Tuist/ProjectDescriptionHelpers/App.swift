//
//  App.swift
//  MyApplicationManifests
//
//  Created by 고병학 on 2023/01/25.
//

import ProjectDescription

let iOSTargetVersion: String = "16.0"
let deploymentTarget: DeploymentTarget = .iOS(
    targetVersion: iOSTargetVersion,
    devices: .iphone
)

public struct AppFactory {
    
    public struct Dependency {
        
        let appDependencies: [TargetDependency]
  
        let unitTestsDependencies: [TargetDependency]
        
        public init(
            appDependencies: [TargetDependency],
            unitTestsDependencies: [TargetDependency]
        ) {
            
            self.appDependencies = appDependencies
            self.unitTestsDependencies = unitTestsDependencies
        }
    }
    
    public struct Payload {
        
        let bundleID: String
        let name: String
        let platform: Platform
        let infoPlist: [String: InfoPlist.Value]
        
        public init(
            bundleID: String,
            name: String,
            platform: Platform,
            infoPlist: [String: InfoPlist.Value]
        ) {
            self.bundleID = bundleID
            self.name = name
            self.platform = platform
            self.infoPlist = infoPlist
        }
    }
    
    private let dependency: Dependency
    
    public init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    public func build(payload: Payload) -> [Target] {
        
        let mainTarget = Target(
            name: payload.name,
            platform: payload.platform,
            product: .app,
            bundleId: payload.bundleID,
            deploymentTarget: deploymentTarget,
            infoPlist: .extendingDefault(with: payload.infoPlist),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            scripts: [.SwiftLintString],
            dependencies: self.dependency.appDependencies,
            settings: .settings(configurations: [
                .debug(name: "Debug", xcconfig: .relativeToRoot("BuildConfigurations/Debug.xcconfig")),
                .release(name: "Release", xcconfig: .relativeToRoot("BuildConfigurations/Release.xcconfig")),
            ])
        )
        
        let testTarget = Target(
            name: "\(payload.name)Tests",
            platform: payload.platform,
            product: .unitTests,
            bundleId: payload.bundleID,
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: payload.name),
            ] + self.dependency.unitTestsDependencies
        )
        
        return [mainTarget, testTarget]
    }
}
