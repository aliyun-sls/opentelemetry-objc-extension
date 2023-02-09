//
//  BatchSpanProcessorObjc.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetrySdk

@objc
public protocol BatchSpanWillExportCallback {
    @objc
    func willExportCallback(_ spanData: [SpanDataObjc])
}

public class BatchSpanProcessorObjc: SpanProcessorObjc {
    var batchSpanProcessor: BatchSpanProcessor
    
    public init(spanExporter: SpanExporterObjc, scheduleDelay: TimeInterval = 5, exportTimeout: TimeInterval = 30,
                maxQueueSize: Int = 2048, maxExportBatchSize: Int = 512, willExportCallback: BatchSpanWillExportCallback? = nil) {
        self.batchSpanProcessor = BatchSpanProcessor(spanExporter: spanExporter.spanExporter, scheduleDelay: scheduleDelay, exportTimeout: exportTimeout, maxQueueSize: maxQueueSize, maxExportBatchSize: maxExportBatchSize, willExportCallback: { spanDatas in
            guard let callback = willExportCallback else {
                return
            }
            
            var spanDataObjcs = [SpanDataObjc]()
            for data in spanDatas {
                spanDataObjcs.append(SpanDataObjc(data))
            }
            
            callback.willExportCallback(spanDataObjcs)
        })
        
        super.init(batchSpanProcessor)
    }
    
    @objc
    public static func processor(_ spanExporter: SpanExporterObjc, scheduleDelay: TimeInterval = 5, exportTimeout: TimeInterval = 30,
                                 maxQueueSize: Int = 2048, maxExportBatchSize: Int = 512, willExportCallback: BatchSpanWillExportCallback? = nil) -> BatchSpanProcessorObjc {
        return BatchSpanProcessorObjc(spanExporter: spanExporter, scheduleDelay: scheduleDelay, exportTimeout: exportTimeout, maxQueueSize: maxQueueSize, maxExportBatchSize: maxExportBatchSize, willExportCallback: willExportCallback)
    }
    
    @objc
    public static func processor(_ spanExporter: SpanExporterObjc) -> BatchSpanProcessorObjc {
        return BatchSpanProcessorObjc(spanExporter: spanExporter)
    }
    
    
    
    
}
