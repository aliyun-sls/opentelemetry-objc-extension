//
//  File.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetryApi

public class ContextPropagatorsObjc: NSObject {
    var contextPropagators: ContextPropagators
    
    
    public var textMapPropagator: TextMapPropagatorObjc {
        get {
            return TextMapPropagatorObjc(contextPropagators.textMapPropagator)
        }
    }
    public var textMapBaggagePropagator: TextMapBaggagePropagatorObjc {
        get {
            return TextMapBaggagePropagatorObjc(contextPropagators.textMapBaggagePropagator)
        }
    }
    
    public init(_ contextPropagators: ContextPropagators) {
        self.contextPropagators = contextPropagators
    }
}
