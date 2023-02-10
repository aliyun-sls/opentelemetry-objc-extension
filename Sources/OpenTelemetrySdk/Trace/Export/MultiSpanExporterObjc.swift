//
//  MultiSpanExporterObjc.swift
//
//
//  Created by gordon on 2023/2/8.
//

import Foundation

import OpenTelemetrySdk

public class MultiSpanExporterObjc : SpanExporterObjc {
    var multiSpanExporter: MultiSpanExporter
    
    
    @objc
    public init(spanExporters: Array<SpanExporterObjc>) {
        var exporters: [SpanExporter] = [SpanExporter]()
        for exporter in spanExporters {
            exporters.append(exporter.spanExporter)
        }
        multiSpanExporter = MultiSpanExporter(spanExporters: exporters)
        super.init(multiSpanExporter)
    }
    
    @objc
    public static func multiSpanExporter(_ spanExporters: Array<SpanExporterObjc>) -> MultiSpanExporterObjc {
        return MultiSpanExporterObjc(spanExporters: spanExporters)
    }

}
