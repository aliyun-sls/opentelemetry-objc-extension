//
//  File.swift
//  
//
//  Created by gordon on 2023/2/8.
//

import Foundation
import OpenTelemetryApi

public class TracerObjc : NSObject {
    var tracer: Tracer
    
    public init(_ tracer: Tracer) {
        self.tracer = tracer
    }
    
    @objc
    public func spanBuilder(_ spanName: String) -> SpanBuilderObjc {
        return SpanBuilderObjc(tracer.spanBuilder(spanName: spanName))
    }
}
