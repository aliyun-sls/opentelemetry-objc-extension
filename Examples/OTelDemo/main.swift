//
//  File.swift
//  
//
//  Created by gordon on 2023/2/8.
//

import Foundation

import GRPC
import NIO
import OpenTelemetryApi
import OpenTelemetrySdk
import OpenTelemetryProtocolExporter
import StdoutExporter
import OpenTelemetryApiObjc

let configuration = ClientConnection.Configuration.default(
    target: .hostAndPort("https://cn-beijing.log.aliyuncs.com", 10010),
    eventLoopGroup: MultiThreadedEventLoopGroup(numberOfThreads: 2)
)
//let configuration = ClientConnection
//    .usingPlatformAppropriateTLS(for: MultiThreadedEventLoopGroup(numberOfThreads: 1))
//    .connect(host: "https://cn-beijing.log.aliyuncs.com", port: 10010)

//let client = ClientConnection(configuration: configuration)

let client = ClientConnection
    .usingPlatformAppropriateTLS(for: MultiThreadedEventLoopGroup(numberOfThreads: 1))
    .connect(host: "cn-beijing.log.aliyuncs.com", port: 10010)

let otlpTraceExporter = OtlpTraceExporter(
    channel: client,
    config: OtlpConfiguration(
        timeout: OtlpConfiguration.DefaultTimeoutInterval,
        headers:
            [
                ("x-sls-otel-project", "qs-demos"),
                ("x-sls-otel-instance-id", "sls-mall"),
                ("x-sls-otel-ak-id", ""),
                ("x-sls-otel-ak-secret", "")
            ]
    )
)
let spanExporters = MultiSpanExporter(spanExporters: [StdoutExporter(isDebug: true), otlpTraceExporter])
let spanProcessor = SimpleSpanProcessor(spanExporter: spanExporters)
OpenTelemetry.registerTracerProvider(
    tracerProvider: TracerProviderBuilder()
        .add(spanProcessor: spanProcessor)
        .with(resource: Resource(attributes:
                                    [
                                        ResourceAttributes.serviceName.rawValue: AttributeValue.string("iOS"),
                                        ResourceAttributes.serviceNamespace.rawValue: AttributeValue.string("Application"),
                                        ResourceAttributes.serviceVersion.rawValue: AttributeValue.string("1.0.0"),
                                        ResourceAttributes.hostName.rawValue: AttributeValue.string("iOS"),
                                        ResourceAttributes.deploymentEnvironment.rawValue: AttributeValue.string("dev"),
                                    ]
                                )
        )
        .build()
)

let tracer = OpenTelemetry.instance.tracerProvider.get(instrumentationName: "OTel Application", instrumentationVersion: "1.0.0")

//OpenTelemetry.registerPropagators(textPropagators: [TextMapPropagatorObjc(W3CTraceContextPropagator)], baggagePropagator: <#T##TextMapBaggagePropagator#>)


func createSpans() {
    let parentSpan1 = tracer.spanBuilder(spanName: "Main").setSpanKind(spanKind: .client).startSpan()
    parentSpan1.setAttribute(key: "key1", value: "value1")
    OpenTelemetry.instance.contextProvider.setActiveSpan(parentSpan1)
    for _ in 1...3 {
        doWork()
    }
    Thread.sleep(forTimeInterval: 0.5)
    
    let parentSpan2 = tracer.spanBuilder(spanName: "Another").setSpanKind(spanKind: .client).setActive(true).startSpan()
    parentSpan2.setAttribute(key: "key2", value: "value2")
    for _ in 1...3 {
        doWork()
    }
    Thread.sleep(forTimeInterval: 0.5)
    
    parentSpan2.end()
    parentSpan1.end()
    
    Thread.sleep(forTimeInterval: 10)
}

func doWork() {
    let childSpan = tracer.spanBuilder(spanName: "doWork").setSpanKind(spanKind: .client).startSpan()
    childSpan.setAttribute(key: "child_key1", value: "child_value1")
    Thread.sleep(forTimeInterval: Double.random(in: 0 ..< 10) / 100)
    childSpan.end()
}

createSpans()
