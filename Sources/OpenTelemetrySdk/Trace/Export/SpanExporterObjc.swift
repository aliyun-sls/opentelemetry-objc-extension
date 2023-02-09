//
//  File.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetrySdk

open class SpanExporterObjc : NSObject {
    public private(set) var spanExporter: SpanExporter
    
    public init(_ spanExporter: SpanExporter) {
        self.spanExporter = spanExporter
    }
    
    @objc
    public class SpanExporterResultCodeObjc : NSObject {
        public static let success = SpanExporterResultCode.success
        public static let failure = SpanExporterResultCode.failure
    }
}
