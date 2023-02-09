//
//  File.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetryApi

public class OpenTelemetryContextProviderObjc : NSObject {
    var contextProvider: OpenTelemetryContextProvider
    
    @objc
    public var activeSpan: SpanObjc? {
        guard let span = contextProvider.activeSpan else {
            return nil
        }
        
        return SpanObjc(span)
    }
    
    public init(_ contextProvider: OpenTelemetryContextProvider) {
        self.contextProvider = contextProvider
    }
    
    @objc
    public func setActiveSpan(_ span: SpanObjc) {
        contextProvider.setActiveSpan(span.span)
    }
    
    @objc
    public func removeContextForSpan(_ span: SpanObjc) {
        contextProvider.removeContextForSpan(span.span)
    }
        
}
