// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "F1-2021-Swift",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "F1-2021-Swift",
            targets: ["F1-2021-Swift"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(
            name: "UDPReader",
            url: "https://github.com/leroythelegend/UDPReader.git",
            from: "1.0.3"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "F1-2021-Swift",
            dependencies: ["UDPReader"]),
        .testTarget(
            name: "F1-2021-SwiftTests",
            dependencies: ["F1-2021-Swift",
                           "UDPReader"],
            resources: [
              // Copy Tests/ExampleTests/Resources directories as-is.
              // Use to retain directory structure.
              // Will be at top level in bundle.
              .copy("testVectors/event_packet.bin"),
              .copy("testVectors/car_damage.bin"),
              .copy("testVectors/motion_data.bin"),
              .copy("testVectors/car_setup.bin"),
              .copy("testVectors/session_packet.bin"),
              .copy("testVectors/participant_data.bin"),
              .copy("testVectors/car_status.bin"),
              .copy("testVectors/history_packet.bin"),
              .copy("testVectors/car_telemetry.bin"),
              .copy("testVectors/lap_data.bin"),
              .copy("testVectors/event_sptp.bin")
            ]),
    ]
)
