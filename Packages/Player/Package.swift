// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Player",
	platforms: [
		.iOS(.v17),
		.tvOS(.v17),
		.macOS(.v14),
		.visionOS(.v1),
	],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Player",
            targets: ["Player"]),
    ],
	dependencies: [
		.package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.15.2"),
	],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
			name: "Player",
			dependencies: [
				.product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
			]
		),
        .testTarget(
            name: "PlayerTests",
            dependencies: ["Player"]
        ),
    ]
)
