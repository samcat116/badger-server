// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "badger-server",
    
    platforms: [.macOS(.v10_15)],
    products: [
        .executable(name: "Badger",
                    targets: ["Badger"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nerdsupremacist/graphzahl-fluent-support.git", from: "0.1.0-alpha.5"),
        .package(url: "https://github.com/nerdsupremacist/graphzahl-vapor-support.git", from: "0.1.0-alpha.7"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.1.0")
    ],
    targets: [
        .target(name: "Badger",
                dependencies: ["GraphZahlFluentSupport", "GraphZahlVaporSupport", "FluentPostgresDriver"],
                path: "./Sources"),
    ]
)
