//
//  File.swift
//  
//
//  Created by gordon on 2023/2/8.
//

import Foundation
import OpenTelemetryApi

public class SpanContextObjc : NSObject {
    var spanContext : SpanContext
    
    
    public init(_ spanContext : SpanContext) {
        self.spanContext = spanContext
    }
    
//    /// The trace identifier associated with this SpanContext
//    @objc
//    public var traceId: TraceIdObjc {
//        get {
//            return TraceIdObjc(spanContext.traceId)
//        }
//    }
//
//    /// The span identifier associated with this  SpanContext
//    public private(set) var spanId: SpanId
//
//    /// The traceFlags associated with this SpanContext
//    public private(set) var traceFlags: TraceFlags
//
//    /// The traceState associated with this SpanContext
//    public var traceState: TraceState
//
//    /// The traceState associated with this SpanContext
//    @objc
//    public let isRemote: Bool
//
//    /// Creates a new SpanContext with the given identifiers and options.
//    /// - Parameters:
//    ///   - traceId: the trace identifier of the span context.
//    ///   - spanId: the span identifier of the span context.
//    ///   - traceFlags: he trace options for the span context.
//    ///   - traceState: the trace state for the span context.
//    public static func create(traceId: TraceId,
//                              spanId: SpanId,
//                              traceFlags: TraceFlags,
//                              traceState: TraceState) -> SpanContextObjc {
//        return SpanContext(traceId: traceId,
//                           spanId: spanId,
//                           traceFlags: traceFlags,
//                           traceState: traceState,
//                           isRemote: false)
//    }
//
//    /// Creates a new SpanContext that was propagated from a remote parent, with the given
//    /// identifiers and options.
//    /// - Parameters:
//    ///   - traceId: the trace identifier of the span context.
//    ///   - spanId: the span identifier of the span context.
//    ///   - traceFlags: he trace options for the span context.
//    ///   - traceState: the trace state for the span context.
//    public static func createFromRemoteParent(traceId: TraceId,
//                                              spanId: SpanId,
//                                              traceFlags: TraceFlags,
//                                              traceState: TraceState) -> SpanContext {
//        return SpanContext(traceId: traceId,
//                           spanId: spanId,
//                           traceFlags: traceFlags,
//                           traceState: traceState,
//                           isRemote: true)
//    }
//
//    /// Returns true if this SpanContext is valid.
//    public var isValid: Bool {
//        return traceId.isValid && spanId.isValid
//    }
//
//    public var isSampled: Bool {
//        return traceFlags.sampled
//    }
//
//    public static func == (lhs: SpanContext, rhs: SpanContext) -> Bool {
//        return lhs.traceId == rhs.traceId && lhs.spanId == rhs.spanId &&
//            lhs.traceFlags == rhs.traceFlags && lhs.isRemote == rhs.isRemote
//    }
//
//    public var description: String {
//        return "SpanContext{traceId=\(traceId), spanId=\(spanId), traceFlags=\(traceFlags)}, isRemote=\(isRemote)"
//    }
//    
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(spanId)
//    }
}
