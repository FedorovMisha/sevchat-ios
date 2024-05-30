// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "sevchat-features",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Authentication",
            targets: ["Authentication"]),
    ],
    dependencies: [
//        .package(name: "sevchat-core", path: "../sevchat-core")
        .package(path: "../sevchat-core/"),
        .package(url: "https://github.com/pointfreeco/swift-url-routing", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "Authentication",
            dependencies: [
                .product(name: "NetSpark", package: "sevchat-core"),
                .product(name: "DaVinci", package: "sevchat-core"),
                .product(name: "Aesthetic", package: "sevchat-core"),
                .product(name: "URLRouting", package: "swift-url-routing"),
            ]
        )
    ]
)
