//
//  StdoutExporterObjc.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetrySdkObjc
import StdoutExporter

public class StdoutExporterObjc : SpanExporterObjc {
    var stdoutExporter: StdoutExporter
    
    public init(_ isDebug: Bool = true) {
        self.stdoutExporter = StdoutExporter(isDebug: isDebug)
        super.init(stdoutExporter)
    }
    
    @objc
    public static func stdoutExporter(_ isDebug: Bool = true) -> StdoutExporterObjc {
        return StdoutExporterObjc(isDebug)
    }
}
