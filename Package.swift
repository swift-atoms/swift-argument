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
        .library(name: "Argument", targets: ["Argument"]),
        .library(name: "Argument Standard Library Integration", targets: ["Argument Standard Library Integration"]),
        .library(name: "Argument Foundation Library Integration", targets: ["Argument Foundation Library Integration"]),
        .library(name: "Argument Test Support", targets: ["Argument Test Support"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Argument",
            dependencies: [
            ],
            path: "Sources/Argument"
        ),
        .target(
            name: "Argument Standard Library Integration",
            dependencies: [
                .target(name: "Argument"),
            ],
            path: "Sources/Argument Standard Library Integration"
        ),
        .target(
            name: "Argument Foundation Library Integration",
            dependencies: [
                .target(name: "Argument"),
                .target(name: "Argument Standard Library Integration"),
            ],
            path: "Sources/Argument Foundation Library Integration"
        ),
        .target(
            name: "Argument Test Support",
            dependencies: [
                .target(name: "Argument"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Argument Tests",
            dependencies: [
                .target(name: "Argument"),
                .target(name: "Argument Test Support"),
                .target(name: "Argument Standard Library Integration"),
                .target(name: "Argument Foundation Library Integration"),
            ],
            path: "Tests/Argument Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
