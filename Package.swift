// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "TextureUI",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_10),
        .tvOS(.v13),
        .watchOS(.v6),
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
        .package(url: "https://github.com/nickaroot/Texture.git", branch: "spm"),
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
