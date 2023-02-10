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
    
    /// Called to export sampled Spans.
    /// - Parameter spans: the list of sampled Spans to be exported.
    @objc
    @discardableResult public func export(spans: [SpanDataObjc]) -> SpanExporterResultCodeObjc {
        var spns = [SpanData]()
        for spn in spans {
            spns.append(spn.spanData)
        }
        return SpanExporterResultCodeObjc(spanExporter.export(spans: spns))
    }

    ///Exports the collection of sampled Spans that have not yet been exported.
    
    @objc
    public func flush() -> SpanExporterResultCodeObjc {
        return SpanExporterResultCodeObjc(spanExporter.flush())
    }
    
    /// Called when TracerSdkFactory.shutdown()} is called, if this SpanExporter is registered
    ///  to a TracerSdkFactory object.
    @objc
    public func shutdown() {
        spanExporter.shutdown()
    }
    
    @objc
    public static func exporter(_ impl: SpanExporterImpl) -> SpanExporterObjc {
        return SpanExporterObjc(SpanExporterWrapper(impl))
    }
}

fileprivate class SpanExporterWrapper: SpanExporter {
    var impl: SpanExporterImpl
    init(_ impl: SpanExporterImpl) {
        self.impl = impl
    }
    
    func export(spans: [SpanData]) -> SpanExporterResultCode {
        var spns = [SpanDataObjc]()
        for spn in spans {
            spns.append(SpanDataObjc(spn))
        }
        
        return impl.export(spns).spanExporterResultCode
    }
    
    func flush() -> SpanExporterResultCode {
        return impl.flush().spanExporterResultCode
    }
    
    func shutdown() {
        impl.shutdown()
    }
}

@objc
public class SpanExporterResultCodeObjc : NSObject {
    public private(set) var spanExporterResultCode: SpanExporterResultCode
    
    @objc
    public static var success: SpanExporterResultCodeObjc {
        return SpanExporterResultCodeObjc(.success)
    }
    
    @objc
    public static var failure: SpanExporterResultCodeObjc {
        return SpanExporterResultCodeObjc(.failure)
    }
    
    public init(_ spanexporterResultCode: SpanExporterResultCode) {
        self.spanExporterResultCode = spanexporterResultCode
    }
}

@objc
public protocol SpanExporterImpl {
    /// Called to export sampled Spans.
    /// - Parameter spans: the list of sampled Spans to be exported.
    @discardableResult func export(_ spans: [SpanDataObjc]) -> SpanExporterResultCodeObjc

    ///Exports the collection of sampled Spans that have not yet been exported.
    func flush() -> SpanExporterResultCodeObjc
    
    /// Called when TracerSdkFactory.shutdown()} is called, if this SpanExporter is registered
    ///  to a TracerSdkFactory object.
    func shutdown()
}
