// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-argument",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Argument",
            targets: ["Argument"]
        ),
        .library(
            name: "Argument Apple Foundation Integration",
            targets: ["Argument Apple Foundation Integration"]
        ),
        .library(
            name: "Argument Test Support",
            targets: ["Argument Test Support"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Argument",
            dependencies: []
        ),
        .target(
            name: "Argument Apple Foundation Integration",
            dependencies: ["Argument"]
        ),
        .target(
            name: "Argument Test Support",
            dependencies: ["Argument"]
        ),
        .testTarget(
            name: "Argument Tests",
            dependencies: [
                "Argument",
                "Argument Test Support",
            ],
            path: "Tests/Argument Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
