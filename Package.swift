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
            name: "Argument Primitive",
            targets: ["Argument Primitive"]
        ),

        .library(
            name: "Argument Position",
            targets: ["Argument Position"]
        ),
        .library(
            name: "Argument Error",
            targets: ["Argument Error"]
        ),
        .library(
            name: "Argument Environment",
            targets: ["Argument Environment"]
        ),
        .library(
            name: "Argument Token",
            targets: ["Argument Token"]
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
            name: "Argument",
            targets: ["Argument"]
        ),

        .library(
            name: "Argument Test Support",
            targets: ["Argument Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-tagged.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-text.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-diagnostic.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-parser.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-finite.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-index.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-byte.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Argument Primitive",
            dependencies: []
        ),

        .target(
            name: "Argument Position",
            dependencies: [
                "Argument Primitive",
                .product(name: "Index", package: "swift-index"),
                .product(name: "Byte", package: "swift-byte"),
            ]
        ),
        .target(
            name: "Argument Error",
            dependencies: [
                "Argument Primitive",
                "Argument Position",
                .product(name: "Diagnostic", package: "swift-diagnostic"),
            ]
        ),
        .target(
            name: "Argument Environment",
            dependencies: [
                "Argument Primitive",
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Argument Token",
            dependencies: [
                "Argument Primitive",
                .product(name: "Text", package: "swift-text"),
            ]
        ),

        .target(
            name: "Argument Positional",
            dependencies: [
                "Argument Primitive",
                .product(name: "Parser", package: "swift-parser"),
            ]
        ),
        .target(
            name: "Argument Option",
            dependencies: [
                "Argument Primitive",
                "Argument Environment",
                .product(name: "Parser", package: "swift-parser"),
            ]
        ),
        .target(
            name: "Argument Flag",
            dependencies: [
                "Argument Primitive",
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Finite", package: "swift-finite"),
            ]
        ),
        .target(
            name: "Argument Group",
            dependencies: [
                "Argument Primitive",
                .product(name: "Parser", package: "swift-parser"),
            ]
        ),
        .target(
            name: "Argument Subcommand",
            dependencies: [
                "Argument Primitive",
                .product(name: "Parser", package: "swift-parser"),
            ]
        ),

        .target(
            name: "Argument Schema",
            dependencies: [
                "Argument Primitive",
                "Argument Positional",
                "Argument Option",
                "Argument Flag",
                "Argument Group",
                "Argument Subcommand",
                .product(name: "Parser", package: "swift-parser"),
            ]
        ),

        .target(
            name: "Argument",
            dependencies: [
                "Argument Primitive",
                "Argument Position",
                "Argument Error",
                "Argument Environment",
                "Argument Token",
                "Argument Positional",
                "Argument Option",
                "Argument Flag",
                "Argument Group",
                "Argument Subcommand",
                "Argument Schema",
            ]
        ),

        .target(
            name: "Argument Test Support",
            dependencies: [
                "Argument",
                .product(
                    name: "Tagged Test Support",
                    package: "swift-tagged"
                ),
                .product(name: "Finite", package: "swift-finite"),
            ],
            path: "Tests/Support"
        ),

        .testTarget(
            name: "Argument Core Tests",
            dependencies: ["Argument Test Support"]
        ),
        .testTarget(
            name: "Argument Positional Tests",
            dependencies: ["Argument Test Support"]
        ),
        .testTarget(
            name: "Argument Option Tests",
            dependencies: ["Argument Test Support"]
        ),
        .testTarget(
            name: "Argument Flag Tests",
            dependencies: ["Argument Test Support"]
        ),
        .testTarget(
            name: "Argument Group Tests",
            dependencies: ["Argument Test Support"]
        ),
        .testTarget(
            name: "Argument Subcommand Tests",
            dependencies: ["Argument Test Support"]
        ),
        .testTarget(
            name: "Argument Schema Tests",
            dependencies: ["Argument Test Support"]
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
