// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SevChatFeatures",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "AuthFeature",
            type: .dynamic,
            targets: ["AuthFeature"]
        ),
    ],
    dependencies: [
        .package(name: "core", path: "../core")
    ],
    targets: [
        .target(
            name: "AuthFeature",
            dependencies: [
                .product(name: "Core", package: "core")
            ]
        )
    ]
)
