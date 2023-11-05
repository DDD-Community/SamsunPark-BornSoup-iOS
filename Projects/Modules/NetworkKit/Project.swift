//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 고병학 on 2023/02/08.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let frameworkName: String = "NetworkKit"

let frameworkTargets: [Target] = FrameworkFactory(
    dependency: .init(
        frameworkDependencies: [Dep.Project.ThirdPartyManager],
        unitTestsDependencies: []
    )
).build(
    payload: .init(
        name: frameworkName,
        platform: .iOS,
        product: .framework,
        infoPlist: ["TEST_FACT_API_KEY": "$(TEST_FACT_API_KEY)"]
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
