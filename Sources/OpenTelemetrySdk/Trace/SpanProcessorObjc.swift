//
//  SpanProcessorObjc.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetrySdk

public class SpanProcessorObjc : NSObject {
    var spanProcessor: SpanProcessor
    
    public init(_ spanProcessor: SpanProcessor) {
        self.spanProcessor = spanProcessor
    }
}
