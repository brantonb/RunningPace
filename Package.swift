// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "RunningPace",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .watchOS(.v2),
        .tvOS(.v9),
    ],
    products: [
        .library(
            name: "RunningPace",
            targets: ["RunningPace"]),
    ],
    targets: [
        .target(
            name: "RunningPace",
            dependencies: []),
        .testTarget(
            name: "RunningPaceTests",
            dependencies: ["RunningPace"]),
    ]
)
