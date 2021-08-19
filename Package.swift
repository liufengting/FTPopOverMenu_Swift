// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "FTPopOverMenu",
    platforms: [ .iOS(.v12), .macOS(.v10_14)],
    products: [
        .library(name: "FTPopOverMenu", targets: ["FTPopOverMenu"]),
    ],
    targets: [
        .target(name: "FTPopOverMenu", path: "FTPopOverMenu")
    ],
    swiftLanguageVersions: [.v4_2, .v5]
)
