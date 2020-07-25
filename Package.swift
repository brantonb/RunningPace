// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "RunningPace",
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
