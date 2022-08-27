// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Microtonality",
    products: [.library(name: "Microtonality", targets: ["Microtonality"])],
    targets: [
        .target(name: "Microtonality"),
        .testTarget(name: "MicrotonalityTests", dependencies: ["Microtonality"]),
    ]
)
