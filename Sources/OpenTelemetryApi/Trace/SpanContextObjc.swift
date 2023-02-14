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
import OpenTelemetryApi

public class SpanContextObjc : NSObject {
    var spanContext : SpanContext
    
    public init(_ spanContext : SpanContext) {
        self.spanContext = spanContext
    }
    
    /// The trace identifier associated with this SpanContext
    @objc
    public var traceId: TraceIdObjc {
        get {
            return TraceIdObjc(spanContext.traceId)
        }
    }
    
    /// The span identifier associated with this  SpanContext
    @objc
    public var spanId: SpanIdObjc {
        get {
            return SpanIdObjc(spanContext.spanId)
        }
    }
    
    /// The traceFlags associated with this SpanContext
    @objc
    public var traceFlags: TraceFlagsObjc {
        get {
            return TraceFlagsObjc(self.traceFlags.traceFlags)
        }
    }
    
    /// The traceState associated with this SpanContext
    @objc
    public var traceState: TraceStateObjc {
        get {
            return TraceStateObjc(spanContext.traceState)
        }
    }
    
    /// The traceState associated with this SpanContext
    @objc
    public var isRemote: Bool {
        get {
            return spanContext.isRemote
        }
    }
    
    /// Creates a new SpanContext with the given identifiers and options.
    /// - Parameters:
    ///   - traceId: the trace identifier of the span context.
    ///   - spanId: the span identifier of the span context.
    ///   - traceFlags: he trace options for the span context.
    ///   - traceState: the trace state for the span context.
    @objc
    public static func create(_ traceId: TraceIdObjc,
                              spanId: SpanIdObjc,
                              traceFlags: TraceFlagsObjc,
                              traceState: TraceStateObjc) -> SpanContextObjc {
        return SpanContextObjc(SpanContext.create(traceId: traceId.traceId,
                                                  spanId: spanId.spanId,
                                                  traceFlags: traceFlags.traceFlags,
                                                  traceState: traceState.traceState
                                                 )
        )
    }
    
    /// Creates a new SpanContext that was propagated from a remote parent, with the given
    /// identifiers and options.
    /// - Parameters:
    ///   - traceId: the trace identifier of the span context.
    ///   - spanId: the span identifier of the span context.
    ///   - traceFlags: he trace options for the span context.
    ///   - traceState: the trace state for the span context.
    @objc
    public static func createFromRemoteParent(_ traceId: TraceIdObjc,
                                              spanId: SpanIdObjc,
                                              traceFlags: TraceFlagsObjc,
                                              traceState: TraceStateObjc) -> SpanContextObjc {
        return SpanContextObjc(
            SpanContext.createFromRemoteParent(traceId: traceId.traceId,
                                               spanId: spanId.spanId,
                                               traceFlags: traceFlags.traceFlags,
                                               traceState: traceState.traceState)
        )
    }
    
    /// Returns true if this SpanContext is valid.
    @objc
    public var isValid: Bool {
        return spanContext.isValid
    }
    
    @objc
    public var isSampled: Bool {
        return spanContext.isSampled
    }
    
    @objc
    public override var description: String {
        return spanContext.description
    }
}
