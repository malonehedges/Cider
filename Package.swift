// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Cider",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "Cider",
            targets: ["Cider"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Cider",
            dependencies: [])
    ],
    swiftLanguageVersions: [.version("5.0")]
)
