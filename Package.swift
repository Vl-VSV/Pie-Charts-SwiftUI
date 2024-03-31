// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PieCharts",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "PieCharts",
            targets: ["PieCharts"]
        ),
    ],
    targets: [
        .target(name: "PieCharts"),
        .testTarget(
            name: "PieChartsTests",
            dependencies: ["PieCharts"]
        ),
    ]
)
