// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "sevchat-core",
    platforms: [
        .iOS(.v16),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "NetSpark",
            targets: [
                "NetSpark"
            ]
        ),
        .library(
            name: "APIModelKit",
            targets: [
                "APIModelKit"
            ]
        ),
        .library(
            name: "ServiceKit",
            targets: [
                "ServiceKit"
            ]
        ),
        .library(
            name: "Aesthetic",
            targets: [
                "Aesthetic"
            ]
        ),
        .library(
            name: "DaVinci",
            targets: [
                "DaVinci"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/kean/Nuke.git", .upToNextMajor(from: "12.5.0")),
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", from: "6.6.0")
    ],
    targets: [
        .target(
            name: "NetSpark",
            dependencies: [
                "Moya",
                "SwiftyBeaver",
                "APIModelKit"
            ]
        ),
        .testTarget(
            name: "NetSparkTests",
            dependencies: [
                "NetSpark"
            ]
        ),
        .target(
            name: "ServiceKit",
            dependencies: [
                "NetSpark",
                "Moya",
                "SwiftyBeaver"
            ]
        ),
        .testTarget(
            name: "ServiceKitTests",
            dependencies: [
                "ServiceKit"
            ]
        ),
        .target(
            name: "Aesthetic",
            dependencies: [
                "Nuke",
                "SwiftyBeaver",
                "DaVinci"
            ]
        ),
        .target(
            name: "APIModelKit",
            dependencies: [
                "SwiftyBeaver"
            ]
        ),
        .target(
            name: "DaVinci",
            resources: [
                .copy("Colors.xcassets"),
                .copy("swiftgen.yml"),
                .copy("Images.xcassets")
            ],
            plugins: [
                .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin"),
            ]
        )
    ]
)
