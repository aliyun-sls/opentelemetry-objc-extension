//
//  File.swift
//  
//
//  Created by gordon on 2023/2/8.
//

import Foundation
import OpenTelemetryApi

public class TracerProviderObjc : NSObject {
    var tracerProvider : TracerProvider
    
    public init(_ tracerProvider: TracerProvider) {
        self.tracerProvider = tracerProvider
    }
    
    @objc
    public func get(_ instrumentationName: String, instrumentationVersion: String? = nil) -> TracerObjc {
        return TracerObjc(self.tracerProvider.get(instrumentationName: instrumentationName, instrumentationVersion: instrumentationVersion))
    }
}
