//
//  File.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetrySdk

public class MultiSpanProcessorObjc : SpanProcessorObjc {
    var multiSpanProcessor: MultiSpanProcessor
    
    public init(_ spanProcessors: Array<SpanProcessorObjc>) {
        var processors = [SpanProcessor]()
        for processor in spanProcessors {
            processors.append(processor.spanProcessor)
        }
        
        self.multiSpanProcessor = MultiSpanProcessor(spanProcessors: processors)
        super.init(multiSpanProcessor)
    }
    
    @objc
    public static func processor(_ spanProcessors: Array<SpanProcessorObjc>) -> MultiSpanProcessorObjc {
        return MultiSpanProcessorObjc(spanProcessors)
    }
    
}
