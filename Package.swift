import PackageDescription

let package = Package(
    name: "BetterMappable",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .Package(url: "https://github.com/tristanhimmelman/ObjectMapper.git", majorVersion: 3, minor: 4),
    ]
)
