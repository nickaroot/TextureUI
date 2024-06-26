// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "TextureUI",
    platforms: [
        .iOS(.v14),
        .tvOS(.v14),
        .watchOS(.v6),
        .macOS(.v11),
    ],
    products: [
        .library(
            name: "TextureUI",
            targets: [
                "TextureUI",
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/nickaroot/Texture.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "TextureUI",
            dependencies: [
                .product(name: "AsyncDisplayKit", package: "Texture"),
            ]
        ),
        .testTarget(
            name: "TextureUITests",
            dependencies: [
                "TextureUI",
            ]
        ),
    ]
)
