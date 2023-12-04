// swift-tools-version: 5.7

import PackageDescription

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
            name: "SPISearchResult"),
        .testTarget(
            name: "SPISearchResultTests",
            dependencies: [
                "SPISearchResult",
                .product(name: "CustomDump", package: "swift-custom-dump"),
            ]
        ),
    ]
)
