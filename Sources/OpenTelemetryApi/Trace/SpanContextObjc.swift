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
}
