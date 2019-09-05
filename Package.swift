// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "FTPopOverMenu",
    platforms: [ .iOS(.v8) ],
    products: [
        .library(name: "FTPopOverMenu", targets: ["FTPopOverMenu_Swift"]),
    ],
    targets: [
        .target(name: "FTPopOverMenu_Swift",
                path: "FTPopOverMenu_Swift")
    ],
    swiftLanguageVersions: [.v4_2, .v5]
)
