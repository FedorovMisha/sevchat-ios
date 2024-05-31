// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "sevchat-features",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Authentication",
            targets: ["Authentication"]),
        .library(
            name: "Main",
            targets: ["Main"]),
    ],
    dependencies: [
//        .package(name: "sevchat-core", path: "../sevchat-core")
        .package(path: "../sevchat-core/")
    ],
    targets: [
        .target(
            name: "Authentication",
            dependencies: [
                .product(name: "DaVinci", package: "sevchat-core"),
                .product(name: "Aesthetic", package: "sevchat-core"),
                .product(name: "NetSpark", package: "sevchat-core"),
            ]
        ),
        .target(
            name: "Main",
            dependencies: [
                .product(name: "DaVinci", package: "sevchat-core"),
                .product(name: "Aesthetic", package: "sevchat-core"),
                .product(name: "NetSpark", package: "sevchat-core"),
                "Authentication"
            ]
        )
    ]
)
