// swift-tools-version:6
import PackageDescription

let package = Package(
    name: "Pactum",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "PactumCore", targets: ["PactumCore"]),
        .library(name: "PactumAuth0", targets: ["PactumCore", "Pactum"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/jwt-kit.git", from: "4.0.0"),
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
