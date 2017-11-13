// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PolymorphSwiftGen",
    products: [
        .library(
            name: "PolymorphSwiftGen",
            targets: ["PolymorphSwiftGen"])
    ],
    dependencies: [
        .package(url: "https://github.com/Digipolitan/polymorph-gen.git", .branch("develop")),
        .package(url: "https://github.com/Digipolitan/swift-code-writer.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "PolymorphSwiftGen",
            dependencies: ["PolymorphGen", "SwiftCodeWriter"]),
        .testTarget(
            name: "PolymorphSwiftGenTests",
            dependencies: ["PolymorphSwiftGen"])
    ]
)
