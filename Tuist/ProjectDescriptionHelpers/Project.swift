//
//  Project.swift
//  MyApplicationManifests
//
//  Created by 고병학 on 2023/01/25.
//

import ProjectDescription

public struct ProjectFactory {
    public struct Dependency {
        
        let appTargets: [Target]
        let frameworkTargets: [Target]
        
        public init(appTargets: [Target], frameworkTargets: [Target]) {
            self.appTargets = appTargets
            self.frameworkTargets = frameworkTargets
        }
    }
    
    public struct Payload {
        
        let name: String
        let organizationName: String
        
        public init(name: String, organizationName: String) {
            self.name = name
            self.organizationName = organizationName
        }
    }
    
    private let dependency: Dependency
    
    public init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    public func build(payload: Payload) -> Project {
        
        return Project(
            name: payload.name,
            organizationName: payload.organizationName,
            settings: .settings(
                configurations: [
                    .debug(name: "Debug", xcconfig: .relativeToRoot("BuildConfigurations/Debug.xcconfig")),
                    .release(name: "Release", xcconfig: .relativeToRoot("BuildConfigurations/Release.xcconfig")),
                ]
            ),
            targets: self.dependency.appTargets + self.dependency.frameworkTargets
        )
    }
}
