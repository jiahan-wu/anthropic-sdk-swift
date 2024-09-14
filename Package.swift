// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "anthropic-sdk-swift",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "Anthropic",
            targets: ["Anthropic"]
        ),
    ],
    targets: [
        .target(
            name: "Anthropic"
        ),
        .testTarget(
            name: "AnthropicTests",
            dependencies: ["Anthropic"]
        ),
    ]
)
