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
            name: "Argument Standard Library Integration",
            targets: ["Argument Standard Library Integration"]
        ),
        .library(
            name: "Argument Apple Foundation Integration",
            targets: ["Argument Apple Foundation Integration"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-tagged.git",
            branch: "main"
        )
    ],
    targets: [
        .target(
            name: "Argument",
            dependencies: [
                .product(name: "Tagged", package: "swift-tagged")
            ]
        ),
        .target(
            name: "Argument Standard Library Integration",
            dependencies: ["Argument"]
        ),
        .target(
            name: "Argument Apple Foundation Integration",
            dependencies: [
                "Argument",
                "Argument Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "Argument Tests",
            dependencies: [
                "Argument",
                .product(name: "Tagged", package: "swift-tagged"),
                .product(
                    name: "Tagged Standard Library Integration",
                    package: "swift-tagged"
                ),
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
