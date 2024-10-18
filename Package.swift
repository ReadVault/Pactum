// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "Pactum",
    platforms: [
        .macOS(.v15)
    ],
    products: [
        .library(name: "PactumCore", targets: ["PactumCore"]),
        .library(name: "Pactum", targets: ["PactumCore", "Pactum"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.106.0"),
        .package(url: "https://github.com/vapor/jwt-kit.git", from: "5.0.1"),
    ],
    targets: [
        .target(
            name: "PactumCore",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "JWTKit", package: "jwt-kit"),
            ]
        ),
        .target(name: "Pactum", dependencies: ["PactumCore"]),
    ]
)
