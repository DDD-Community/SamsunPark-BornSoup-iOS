//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 고병학 on 2023/02/08.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let frameworkName: String = "DataKit"

let frameworkTargets: [Target] = FrameworkFactory(
    dependency: .init(
        frameworkDependencies: [
            Dep.Project.DomainKit,
            Dep.Project.CoreKit,
            Dep.Project.NetworkKit
        ],
        unitTestsDependencies: [
            Dep.Project.DomainKit,
            Dep.Project.CoreKit,
            Dep.Project.NetworkKit
        ]
    )
).build(
    payload: .init(
        name: frameworkName,
        platform: .iOS,
        product: .staticLibrary
    )
)

let project = ProjectFactory(
    dependency: .init(
        appTargets: [],
        frameworkTargets: frameworkTargets
    )
).build(
    payload: .init(
        name: frameworkName,
        organizationName: "kr.ddd.ozeon"
    )
)
