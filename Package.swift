// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftExperiments",
    platforms: [
      .macOS(.v10_12),
      .iOS(.v12),
      .tvOS(.v12)
    ],
    products: [
      .library(
          name: "SwiftExperiments",
          targets: ["SwiftExperiments"]),
    ],
    dependencies: [
      .package(url: "https://github.com/JohnSundell/Identity", from: "0.3.0"),
      .package(url: "https://github.com/alexruperez/Tagging", from: "0.1.0")

    ],
    targets: [
      .target(
          name: "SwiftExperiments",
          dependencies: ["Identity", "Tagging"]),
      .testTarget(
          name: "SwiftExperimentsTests",
          dependencies: ["SwiftExperiments", "Identity", "Tagging"]),
    ]
)
