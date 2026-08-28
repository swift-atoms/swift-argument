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
            name: "Argument Positional",
            targets: ["Argument Positional"]
        ),
        .library(
            name: "Argument Option",
            targets: ["Argument Option"]
        ),
        .library(
            name: "Argument Flag",
            targets: ["Argument Flag"]
        ),
        .library(
            name: "Argument Group",
            targets: ["Argument Group"]
        ),
        .library(
            name: "Argument Subcommand",
            targets: ["Argument Subcommand"]
        ),
        .library(
            name: "Argument Schema",
            targets: ["Argument Schema"]
        ),
        .library(
            name: "Argument Schema Test Support",
            targets: ["Argument Schema Test Support"]
        ),
    ],
    targets: [
        .target(
            name: "Argument"
        ),
        .target(
            name: "Argument Positional",
            dependencies: [
                .target(name: "Argument"),
            ]
        ),
        .target(
            name: "Argument Option",
            dependencies: [
                .target(name: "Argument"),
            ]
        ),
        .target(
            name: "Argument Flag",
            dependencies: [
                .target(name: "Argument"),
            ]
        ),
        .target(
            name: "Argument Group",
            dependencies: [
                .target(name: "Argument"),
            ]
        ),
        .target(
            name: "Argument Subcommand",
            dependencies: [
                .target(name: "Argument"),
            ]
        ),
        .target(
            name: "Argument Schema",
            dependencies: [
                .target(name: "Argument"),
                .target(name: "Argument Positional"),
                .target(name: "Argument Option"),
                .target(name: "Argument Flag"),
                .target(name: "Argument Group"),
                .target(name: "Argument Subcommand"),
            ]
        ),
        .target(
            name: "Argument Schema Test Support",
            dependencies: [
                .target(name: "Argument Schema"),
            ],
            path: "Tests/Argument Schema Test Support"
        ),
        .testTarget(
            name: "Argument Tests",
            dependencies: [
                .target(name: "Argument"),
            ]
        ),
        .testTarget(
            name: "Argument Positional Tests",
            dependencies: [
                .target(name: "Argument Positional"),
            ]
        ),
        .testTarget(
            name: "Argument Option Tests",
            dependencies: [
                .target(name: "Argument Option"),
            ]
        ),
        .testTarget(
            name: "Argument Flag Tests",
            dependencies: [
                .target(name: "Argument Flag"),
            ]
        ),
        .testTarget(
            name: "Argument Group Tests",
            dependencies: [
                .target(name: "Argument Group"),
            ]
        ),
        .testTarget(
            name: "Argument Subcommand Tests",
            dependencies: [
                .target(name: "Argument Subcommand"),
            ]
        ),
        .testTarget(
            name: "Argument Schema Tests",
            dependencies: [
                .target(name: "Argument Schema"),
                .target(name: "Argument Schema Test Support"),
            ]
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
