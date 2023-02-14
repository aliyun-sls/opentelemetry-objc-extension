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
