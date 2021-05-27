// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MicrotonalAudioKit",
    platforms: [.macOS(.v10_14), .iOS(.v13), .tvOS(.v13)],
    products: [.library(name: "MicrotonalAudioKit", targets: ["MicrotonalAudioKit"])],
    dependencies: [.package(url: "https://github.com/AudioKit/AudioKit", .branch("develop"))],
    targets: [
        .target(name: "MicrotonalAudioKit", dependencies: ["AudioKit"]),
        .testTarget(name: "MicrotonalAudioKitTests", dependencies: ["MicrotonalAudioKit"])
    ]
)
