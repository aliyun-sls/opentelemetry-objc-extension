//
//  File.swift
//  
//
//  Created by gordon on 2023/2/8.
//

import Foundation
import OpenTelemetryApi

public class SpanKindObjc : NSObject {
    public private (set) var spanKind : SpanKind
    
    @objc
    public static var INTERNAL: SpanKindObjc {
        return SpanKindObjc(SpanKind.internal)
    }
    
    @objc
    public static var SERVER: SpanKindObjc {
        return SpanKindObjc(SpanKind.server)
    }
    
    @objc
    public static var CLIENT: SpanKindObjc {
        return SpanKindObjc(SpanKind.client)
    }
    
    @objc
    public static var PRODUCER: SpanKindObjc {
        return SpanKindObjc(SpanKind.producer)
    }
    
    @objc
    public static var CONSUMER: SpanKindObjc {
        return SpanKindObjc(SpanKind.consumer)
    }
    
    
    public init(_ spanKind: SpanKind) {
        self.spanKind = spanKind
    }
}
