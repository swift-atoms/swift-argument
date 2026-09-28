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
    traits: [
        .trait(name: "Diagnostic", description: "Absorbed swift-argument-diagnostic APIs", enabledTraits: ["Index"]),
        .trait(name: "Index", description: "Absorbed swift-argument-index APIs"),
        .trait(name: "Tagged", description: "Typed environment-variable names"),
        .trait(name: "Finite", description: "Enumerable flag names and help"),
        .trait(name: "Text", description: "Argument tokens with source ranges"),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-molecules/swift-diagnostic.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-ordinal.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-byte.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-index.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-tagged.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-finite.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-text.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-cardinal.git", branch: "main"),
    ],
    targets: [
        .testTarget(
            name: "Absorbed swift-argument-diagnostic Tests",
            dependencies: [
                .target(name: "Argument"),
                .product(name: "Diagnostic", package: "swift-diagnostic", condition: .when(traits: ["Diagnostic"])),
            ],
            path: "Tests/Absorbed swift-argument-diagnostic"
        ),
        .testTarget(
            name: "Absorbed swift-argument-index Tests",
            dependencies: [
                .target(name: "Argument"),
                .product(name: "Index", package: "swift-index", condition: .when(traits: ["Index", "Diagnostic"])),
                .product(name: "Byte", package: "swift-byte", condition: .when(traits: ["Index", "Diagnostic"])),
                .product(name: "Ordinal", package: "swift-ordinal", condition: .when(traits: ["Index", "Diagnostic"])),
                .product(name: "Tagged", package: "swift-tagged", condition: .when(traits: ["Index", "Diagnostic"])),
            ],
            path: "Tests/Absorbed swift-argument-index"
        ),
        .target(
            name: "Argument",
            dependencies: [
                .product(name: "Diagnostic", package: "swift-diagnostic", condition: .when(traits: ["Diagnostic"])),
                .product(name: "Index", package: "swift-index", condition: .when(traits: ["Index", "Diagnostic"])),
                .product(name: "Byte", package: "swift-byte", condition: .when(traits: ["Index", "Diagnostic"])),
                .product(name: "Ordinal", package: "swift-ordinal", condition: .when(traits: ["Index", "Diagnostic"])),
                .product(name: "Tagged", package: "swift-tagged", condition: .when(traits: ["Tagged"])),
                .product(name: "Finite", package: "swift-finite", condition: .when(traits: ["Finite"])),
                .product(name: "Text", package: "swift-text", condition: .when(traits: ["Text"])),
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
