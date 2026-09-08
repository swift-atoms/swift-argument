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

        .library(name: "Argument Foundation Integration", targets: ["Argument Foundation Integration"]),
        .library(name: "Argument Test Support", targets: ["Argument Test Support"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-cardinal.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Argument",
            dependencies: [
                .product(name: "Cardinal", package: "swift-cardinal"),
            ],
            path: "Sources/Argument"
        ),
        
        .target(
            name: "Argument Foundation Integration",
            dependencies: [
                .target(name: "Argument"),
            ],
            path: "Sources/Argument Foundation Integration"
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
                .target(name: "Argument Foundation Integration"),
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
