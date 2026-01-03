// swift-tools-version: 5.9
import PackageDescription

let package = Package(
  name: "Kraven in the Safari",
  platforms: [.macOS(.v13)],
  dependencies: [],
  targets: [
    .executableTarget(
      name: "Kraven",
      dependencies: [],
      path: "Kraven"
    )
  ]
)
