// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SevChatCore",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Core",
            targets: ["Core", "CoreAPIModels"]
        ),
        .library(
            name: "CoreAPIModels",
            targets: ["CoreAPIModels"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/daltoniam/Starscream.git", from: "4.0.6"),
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: [
                .product(name: "Starscream", package: "Starscream"),
                .product(name: "Moya", package: "Moya"),
                "CoreAPIModels"
            ]
        ),
        .target(
            name: "CoreAPIModels",
            dependencies: [
                .product(name: "Moya", package: "Moya")
            ]
        ),
        .testTarget(
            name: "CoreAPIModelsTests",
            dependencies: ["CoreAPIModels"]
        )
    ]
)
