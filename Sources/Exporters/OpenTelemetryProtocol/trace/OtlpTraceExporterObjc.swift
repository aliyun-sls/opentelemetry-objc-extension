// Copyright 2023 aliyun-sls Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation

import GRPC
import NIO
import OpenTelemetryProtocolExporter
import OpenTelemetrySdkObjc


public class OtlpTraceExporterObjc : SpanExporterObjc {
    var otelExporter: OtlpTraceExporter
    
    @objc
    public init(host: String, port: Int, tls: Bool = true, numberOfThreads: Int = 1, configuration: OtlpConfigurationObjc = OtlpConfigurationObjc()) {
        var client : ClientConnection
        if tls {
            client = ClientConnection
                .usingPlatformAppropriateTLS(for: MultiThreadedEventLoopGroup(numberOfThreads: numberOfThreads))
                .connect(host: host, port: port)
        } else {
            client = ClientConnection(
                configuration: ClientConnection.Configuration.default(
                    target: .hostAndPort(host, port),
                    eventLoopGroup: MultiThreadedEventLoopGroup(numberOfThreads: numberOfThreads)
                )
            )
        }
        
        otelExporter = OtlpTraceExporter(
            channel: client,
            config: configuration.otlpConfiguration
        )
        super.init(otelExporter)
    }
    
    @objc
    public static func exporter(_ host: String, port: Int, tls: Bool = true, numberOfThreads: Int = 1, configuration: OtlpConfigurationObjc) -> OtlpTraceExporterObjc {
        return OtlpTraceExporterObjc(host: host, port: port, tls: tls, numberOfThreads: numberOfThreads, configuration: configuration)
    }
    
    @objc
    public static func exporter(_ host: String, port: Int, tls: Bool = true, configuration: OtlpConfigurationObjc) -> OtlpTraceExporterObjc {
        return exporter(host, port: port, tls: tls, numberOfThreads: 1, configuration: configuration)
    }
    
    @objc
    public static func exporter(_ host: String, port: Int, configuration: OtlpConfigurationObjc) -> OtlpTraceExporterObjc {
        return exporter(host, port: port, tls: true, configuration: configuration)
    }
}
