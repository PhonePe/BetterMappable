// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "BetterMappable",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "BetterMappable",
            targets: [
                "BetterMappable-iOS",
                "BetterMappable-macOS",
                "BetterMappable-tvOS",
                "BetterMappable-watchOS",
            ]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/tristanhimmelman/ObjectMapper.git",
            from: "3.5.1"
        )
    ],
    targets: [
        .target(name: "BetterMappable-iOS", dependencies: [], path: "Source"),
        .target(name: "BetterMappable-macOS", dependencies: [], path: "Source"),
        .target(name: "BetterMappable-tvOS", dependencies: [], path: "Source"),
        .target(name: "BetterMappable-watchOS", dependencies: [], path: "Source"),
        .testTarget(name: "BetterMappable-iOSTests", dependencies: ["BetterMappable-iOS"], path: "Tests"),
        .testTarget(name: "BetterMappable-macOSTests", dependencies: ["BetterMappable-macOS"], path: "Tests"),
        .testTarget(name: "BetterMappable-tvOSTests", dependencies: ["BetterMappable-tvOS"], path: "Tests")
    ],
    swiftLanguageVersions: [
        .version("5.1")
    ]
)
