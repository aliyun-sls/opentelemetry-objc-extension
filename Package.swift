// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "opentelemetry-objc-extension",
    platforms: [.macOS(.v10_13),
                .iOS(.v11),
                .tvOS(.v11),
                .watchOS(.v3)],
    products: [
        .library(
            name: "OpenTelemetrySdkObjc",
            type: .static,
            targets: ["OpenTelemetrySdkObjc"]
        ),
        .library(
            name: "OpenTelemetryApiObjc",
            targets: ["OpenTelemetryApiObjc"]
        ),
        .library(
            name: "URLSessionInstrumentationObjc",
            targets: ["URLSessionInstrumentationObjc"]
        ),
        .library(
            name: "OpenTelemetryProtocolExporterObjc",
            targets: ["OpenTelemetryProtocolExporterObjc"]
        ),
        .library(
            name: "StdoutExporterObjc",
            targets: ["StdoutExporterObjc"]
        ),
        .library(
            name: "ResourceExtensionObjc",
            targets: ["ResourceExtensionObjc"]
        ),
        .executable(name: "OTelDemo", targets: ["OTelDemo"])
    ],
    dependencies: [
        .package(url:"https://github.com/open-telemetry/opentelemetry-swift", from: "1.4.0"),
    ],
    targets: [
        .target(
            name: "OpenTelemetrySdkObjc",
            dependencies: [
                .product(name: "OpenTelemetrySdk", package: "opentelemetry-swift")
            ],
            path: "Sources/",
            sources: ["OpenTelemetrySdk/"]
        ),
        .target(
            name: "OpenTelemetryApiObjc",
            dependencies: [
                .product(name: "OpenTelemetryApi", package: "opentelemetry-swift")
            ],
            path: "Sources/",
            sources: ["OpenTelemetryApi/"]
        ),
        .target(
            name: "OpenTelemetryProtocolExporterObjc",
            dependencies: [
                .product(name: "OpenTelemetryProtocolExporter", package: "opentelemetry-swift")
            ],
            path: "Sources/Exporters/OpenTelemetryProtocol"
        ),
        .target(
            name: "StdoutExporterObjc",
            dependencies: [
                .byName(name: "OpenTelemetrySdkObjc"),
                .product(name: "StdoutExporter", package: "opentelemetry-swift")
            ],
            path: "Sources/Exporters/Stdout"
        ),
        .target(
            name: "URLSessionInstrumentationObjc",
            dependencies: [
                .product(name: "URLSessionInstrumentation", package: "opentelemetry-swift")
            ],
            path: "Sources/Instrumentation/URLSession",
            exclude: ["README.md"]
        ),
        .target(
            name: "ResourceExtensionObjc",
            dependencies: [
                .byName(name: "OpenTelemetrySdkObjc"),
                .product(name: "ResourceExtension", package: "opentelemetry-swift")
            ],
            path: "Sources/Instrumentation/SDKResourceExtension"
        ),
        .target(
            name: "OTelDemo",
            dependencies: [
                .product(name: "OpenTelemetryApi", package:"opentelemetry-swift"),
                .product(name: "OpenTelemetrySdk", package:"opentelemetry-swift"),
                .product(name: "OpenTelemetryProtocolExporter", package:"opentelemetry-swift"),
                .product(name: "StdoutExporter", package:"opentelemetry-swift"),
                .product(name: "URLSessionInstrumentation", package:"opentelemetry-swift")
                
            ],
            path: "Examples/",
            sources: ["OTelDemo/"]
        ),
        .testTarget(
            name: "OpenTelemetryApiTest",
            dependencies: ["OpenTelemetryApiObjc"],
            path: "Tests/OpenTelemetryApiTest"
        ),
    ]
)
