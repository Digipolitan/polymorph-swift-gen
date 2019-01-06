PolymorphSwiftGen
=================================

[![Swift Version](https://img.shields.io/badge/swift-4.2-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Swift Package Manager](https://rawgit.com/jlyonsmith/artwork/master/SwiftPackageManager/swiftpackagemanager-compatible.svg)](https://swift.org/package-manager/)
[![Twitter](https://img.shields.io/badge/twitter-@Digipolitan-blue.svg?style=flat)](http://twitter.com/Digipolitan)

Swift implementation of [PlatformGen](https://github.com/Digipolitan/polymorph-gen)
- Models

## Installation

### SPM

To install PolymorphSwiftGen with SwiftPackageManager, add the following lines to your `Package.swift`.

```swift
let package = Package(
    name: "XXX",
    products: [
        .library(
            name: "XXX",
            targets: ["XXX"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Digipolitan/polymorph-swift-gen.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "XXX",
            dependencies: ["PolymorphSwiftGen"])
    ]
)
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for more details!

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md).
By participating, you are expected to uphold this code. Please report
unacceptable behavior to [contact@digipolitan.com](mailto:contact@digipolitan.com).

## License

PolymorphSwiftGen is licensed under the [BSD 3-Clause license](LICENSE).
