//
//  File.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetryApi

public class TraceIdObjc : NSObject {
    public var traceId: TraceId
    
    public init(_ traceId: TraceId) {
        self.traceId = traceId
    }
    
    /// Generates a new random TraceId.
    @objc
    public static func random() -> TraceIdObjc {
        return TraceIdObjc(TraceId.random())
    }

    /// Returns a TraceId built from a lowercase base16 representation.
    /// - Parameters:
    ///   - hexString: the lowercase base16 representation.
    ///   - offset: the offset in the buffer where the representation of the TraceId begins.
    @objc
    public static func traceId(_ hexString: String, offset: Int = 0) -> TraceIdObjc {
        return TraceIdObjc(TraceId(fromHexString: hexString, withOffset: offset))
    }
    
    /// Returns whether the TraceId is valid. A valid trace identifier is a 16-byte array with
    /// at least one non-zero byte.
    @objc
    public var isValid: Bool {
        return traceId.isValid
    }

    /// Returns the lowercase base16 encoding of this TraceId.
    @objc
    public var hexString: String {
        return traceId.hexString
    }

    /// Returns the lower 8 bytes of the trace-id as a long value, assuming little-endian order. This
    /// is used in ProbabilitySampler.
    @objc
    public var rawHigherLong: UInt64 {
        return traceId.rawHigherLong
    }

    /// Returns the lower 8 bytes of the trace-id as a long value, assuming little-endian order. This
    /// is used in ProbabilitySampler.
    @objc
    public var rawLowerLong: UInt64 {
        return traceId.rawLowerLong
    }

    @objc
    public override var description: String {
        return traceId.description
    }
}
