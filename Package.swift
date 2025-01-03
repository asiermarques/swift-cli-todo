// swift-tools-version:5.9.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CLITodo",
    targets: [
        .executableTarget(
            name: "CLITodo",
            path: "Sources"
        ),
        .testTarget(
            name: "TodoTests",
            dependencies: ["CLITodo"]
        ),
    ]
)
