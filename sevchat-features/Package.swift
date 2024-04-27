// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "sevchat-features",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "sevchat-features",
            targets: ["sevchat-features"]),
    ],
    targets: [
        .target(
            name: "sevchat-features"),
        .testTarget(
            name: "sevchat-featuresTests",
            dependencies: ["sevchat-features"]),
    ]
)
