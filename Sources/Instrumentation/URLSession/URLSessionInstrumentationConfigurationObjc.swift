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
import URLSessionInstrumentation
import OpenTelemetryApiObjc

public class URLSessionInstrumentationConfigurationObjc: NSObject {
    public private(set) var urlSessionInstrumentationConfiguration: URLSessionInstrumentationConfiguration
    
    public init(_ urlSessionInstrumentationConfiguration: URLSessionInstrumentationConfiguration) {
        self.urlSessionInstrumentationConfiguration = urlSessionInstrumentationConfiguration
    }
    
    @objc
    public static func urlSessionInstrumentationConfiguration(_ impl: URLSessionInstrumentationConfigurationImpl) -> URLSessionInstrumentationConfigurationObjc {
        return URLSessionInstrumentationConfigurationObjc(URLSessionInstrumentationConfiguration(
            shouldRecordPayload: { session in
                return impl.shouldRecordPayload(session)
            }, shouldInstrument: { request in
                return impl.shouldInstrument(request)
            }, nameSpan: { request in
                return impl.nameSpan(request)
            }, spanCustomization: { request, spanBuilder in
                impl.spanCustomization(request, spanBuilder: SpanBuilderObjc(spanBuilder))
            }, shouldInjectTracingHeaders: { request in
                return impl.shouldInjectTracingHeaders(request)
            }, injectCustomHeaders: { request, span in
                if let _ = span {
                    impl.injectCustomHeaders(request, span: SpanObjc(span!))
                } else {
                    impl.injectCustomHeaders(request, span: nil)
                }
            }, createdRequest: { request, span in
                impl.createdRequest(request, span: SpanObjc(span))
            }, receivedResponse: { response, dataOrFile, span in
                impl.receivedResponse(response, dataOrFile: dataOrFile as? NSObject, span: SpanObjc(span))
            }, receivedError: { error, dataOrFile, httpStatus, span in
                impl.receivedError(error, dataOrFile: dataOrFile as? NSObject, span: SpanObjc(span))
            }
        )
        )
    }
}

@objc
public protocol URLSessionInstrumentationConfigurationImpl {
    /// Implement this callback to filter which requests you want to instrument, all by default
    func shouldInstrument(_ request: URLRequest) -> Bool
    
    /// Implement this callback if you want the session to record payload data, false by default.
    /// This callback is only necessary when using session delegate
    func shouldRecordPayload(_ session: URLSession) -> Bool
    
    /// Implement this callback to filter which requests you want to inject headers to follow the trace,
    /// also must implement it if you want to inject custom headers
    /// Instruments all requests by default
    func shouldInjectTracingHeaders(_ request: URLRequest) -> Bool
    
    /// Implement this callback to inject custom headers or modify the request in any other way
    func injectCustomHeaders(_ request: URLRequest, span: SpanObjc?)
    
    /// Implement this callback to override the default span name for a given request, return nil to use default.
    /// default name: `HTTP {method}` e.g. `HTTP PUT`
    func nameSpan(_ request: URLRequest) -> String?
    
    /// Implement this callback to customize the span, such as by adding a parent, a link, attributes, etc
    func spanCustomization(_ request: URLRequest, spanBuilder: SpanBuilderObjc)
    
    ///  Called before the span is created, it allows to add extra information to the Span
    func createdRequest(_ request: URLRequest, span: SpanObjc)
    
    ///  Called before the span is ended, it allows to add extra information to the Span
    func receivedResponse(_ response: URLResponse, dataOrFile: NSObject?, span: SpanObjc)
    
    ///  Called before the span is ended, it allows to add extra information to the Span
    func receivedError(_ error: Error, dataOrFile: NSObject?, span: SpanObjc)
}
