//
//  File.swift
//  
//
//  Created by gordon on 2023/2/8.
//

import Foundation

import OpenTelemetryApi
import OpenTelemetrySdk

public class SimpleSpanProcessorObjc : SpanProcessorObjc {
    var simpleSpanProcessor: SimpleSpanProcessor
    
    @objc
    public init(spanExporter: SpanExporterObjc) {
        simpleSpanProcessor = SimpleSpanProcessor(spanExporter: spanExporter.spanExporter)
        super.init(simpleSpanProcessor)
    }
    
    @objc
    public static func processor(_ spanExporter: SpanExporterObjc) -> SimpleSpanProcessorObjc {
        return SimpleSpanProcessorObjc(spanExporter: spanExporter)
    }
    
}
