// swift-tools-version:5.9
// The TheoremReach iOS SDK as a Swift package: the same xcframework the CocoaPods pod ships. Playtime (adjoe) isn't
// part of it: the SDK weak-links adjoe, so an app that turns Playtime on adds adjoe's own package, PlaytimeMonetize.
import PackageDescription

let package = Package(
    name: "TheoremReachSDK",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "TheoremReachSDK", targets: ["TheoremReachSDK"])
    ],
    targets: [
        .binaryTarget(name: "TheoremReachSDK", path: "TheoremReachSDK.xcframework")
    ]
)
