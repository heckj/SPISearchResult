// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "SPISearchResult",
    products: [
        .library(
            name: "SPISearchResult",
            targets: ["SPISearchResult"]
        ),
    ],
    targets: [
        .target(
            name: "SPISearchResult"),
        .testTarget(
            name: "SPISearchResultTests",
            dependencies: ["SPISearchResult"]
        ),
    ]
)
