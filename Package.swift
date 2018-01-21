// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Tempura",
    products: [
        .library(
            name: "Tempura",
            targets: ["Tempura"]),
    ],
    targets: [
        .target(
            name: "Tempura",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "Tests-iOS",
            dependencies: ["Tempura"],
            path: "Tests"),
    ]
)
