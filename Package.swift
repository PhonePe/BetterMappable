// swift-tools-version:5.0
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
        .library(name: "BetterMappable", targets: ["BetterMappable"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/tristanhimmelman/ObjectMapper.git",
            from: "3.5.1"
        )
    ],
    targets: [
        .target(name: "BetterMappable", dependencies: [], path: "Source"),
        .testTarget(name: "BetterMappableTests", dependencies: ["BetterMappable"], path: "Tests")
    ],
    swiftLanguageVersions: [.version("5.1")]
)
