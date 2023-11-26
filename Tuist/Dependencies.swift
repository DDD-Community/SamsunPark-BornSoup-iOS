import ProjectDescription

let carthage = CarthageDependencies([])

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "1.2.0")),
    .remote(url: "https://github.com/onevcat/Kingfisher", requirement: .upToNextMajor(from: "7.8.1")),
    .remote(url: "https://github.com/Swinject/Swinject", requirement: .upToNextMajor(from: "2.8.3")),
    .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .upToNextMajor(from: "5.7.0")),
    .remote(url: "https://github.com/kakao/kakao-ios-sdk", requirement: .upToNextMinor(from: "2.18.0")),
    .remote(url: "https://github.com/kishikawakatsumi/KeychainAccess", requirement: .upToNextMajor(from: "4.2.2")),
    .remote(url: "https://github.com/Kitura/Swift-JWT", requirement: .upToNextMajor(from: "4.0.0"))
])

let dependencies = Dependencies(
    carthage: carthage,
    swiftPackageManager: spm,
    platforms: [.iOS]
)
