// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "WindowlessScreenShotApp",
    platforms: [.macOS(.v13)],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "WindowlessScreenShotApp",
            dependencies: [],
            path: "WindowlessScreenShotApp"
        )
    ]
)
