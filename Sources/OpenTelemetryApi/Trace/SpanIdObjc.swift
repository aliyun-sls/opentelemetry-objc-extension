//
//  File.swift
//  
//
//  Created by gordon on 2023/2/10.
//

import Foundation
import OpenTelemetryApi

public class SpanIdObjc: NSObject {
    public private(set) var spanId: SpanId
    
    public init(_ spanId: SpanId) {
        self.spanId = spanId
    }
    
    /// Generates a new random SpanId.
    @objc
    public static func random() -> SpanIdObjc {
        return SpanIdObjc(SpanId.random())
    }
    
    ///  Returns the base16 encoding of this SpanId.
    @objc
    public var hexString: String {
        return spanId.hexString
    }

    ///  Returns the raw id value of this SpanId.
    @objc
    public var rawValue: UInt64 {
        return spanId.rawValue
    }

    /// Returns whether the span identifier is valid. A valid span identifier is an 8-byte array with
    /// at least one non-zero byte.
    @objc
    public var isValid: Bool {
        return spanId.isValid
    }

    @objc
    public override var description: String {
        // return "SpanId{spanId=" + toLowerBase16() + "}";
        return spanId.description
    }
}
