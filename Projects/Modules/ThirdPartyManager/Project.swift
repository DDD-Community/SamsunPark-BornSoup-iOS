//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 고병학 on 2023/02/10.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let frameworkName: String = "ThirdPartyManager"

let frameworkTargets: [Target] = FrameworkFactory(
    dependency: .init(
        frameworkDependencies: [
            .SPM.Kingfisher,
            .SPM.TCA,
            .SPM.Alamofire,
            .SPM.Swinject,
            .SPM.KakaoSDKAuth,
            .SPM.KakaoSDKUser,
            .SPM.KakaoSDKCommon,
            .SPM.KeychainAccess,
            .SPM.SwiftJWT,
            .SPM.FirebaseStorage
        ],
        unitTestsDependencies: []
    )
).build(
    payload: .init(
        name: frameworkName,
        platform: .iOS,
        product: .staticFramework
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
