// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MicrotonalAudioKit",
    platforms: [.macOS(.v10_13), .iOS(.v11), .tvOS(.v11)],
    products: [.library(name: "MicrotonalAudioKit", targets: ["MicrotonalAudioKit"])],
    dependencies: [.package(url: "https://github.com/AudioKit/AudioKit", from: "5.3.0")],
    targets: [
        .target(name: "MicrotonalAudioKit", dependencies: ["AudioKit"]),
        .testTarget(name: "MicrotonalAudioKitTests", dependencies: ["MicrotonalAudioKit"]),
    ]
)
