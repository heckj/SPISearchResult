// swift-tools-version: 5.8

import PackageDescription

var globalSwiftSettings: [PackageDescription.SwiftSetting] = [.enableExperimentalFeature("StrictConcurrency")]

let package = Package(
    name: "SPISearchResult",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(
            name: "SPISearchResult",
            targets: ["SPISearchResult"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-custom-dump.git", from: "1.1.0"),
    ],
    targets: [
        .target(
            name: "SPISearchResult",
            dependencies: [],
            swiftSettings: globalSwiftSettings
        ),
        .testTarget(
            name: "SPISearchResultTests",
            dependencies: [
                "SPISearchResult",
                .product(name: "CustomDump", package: "swift-custom-dump"),
            ]
        ),
    ]
)
