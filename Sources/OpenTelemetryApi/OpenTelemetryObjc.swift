//
//  File.swift
//  
//
//  Created by gordon on 2023/2/8.
//

import Foundation
import OpenTelemetryApi

public class OpenTelemetryObjc : NSObject {

    @objc
    public static var instance = OpenTelemetryObjc()
    
    @objc
    public var tracerProvider: TracerProviderObjc {
        get {
            return TracerProviderObjc(OpenTelemetry.instance.tracerProvider)
        }
    }
    
    @objc
    public var contextProvider: OpenTelemetryContextProviderObjc {
        get {
            return OpenTelemetryContextProviderObjc(OpenTelemetry.instance.contextProvider)
        }
    }
    
    @objc
    public var baggageManager: BaggageManagerObjc {
        get {
            return BaggageManagerObjc(OpenTelemetry.instance.baggageManager)
        }
    }
    
    @objc
    public var propagators: ContextPropagatorsObjc {
        get {
            return ContextPropagatorsObjc(OpenTelemetry.instance.propagators)
        }
    }
    
    
    private override init() {

    }
    
    @objc
    public static func registerTracerProvider(_ tracerProvider: TracerProviderObjc) {
        OpenTelemetry.registerTracerProvider(tracerProvider: tracerProvider.tracerProvider)
    }
    
    @objc
    public static func registerContextManager(_ contextManager: ContextManagerObjc) {
        OpenTelemetry.registerContextManager(contextManager: contextManager.contextManager)
    }
    
    @objc
    public static func registerPropagators(textPropagators: [TextMapPropagatorObjc], baggagePropagator: TextMapBaggagePropagatorObjc) {
        var propagators = [TextMapPropagator]()
        for propagator in textPropagators {
            propagators.append(propagator.textMapPropagator)
        }

        OpenTelemetry.registerPropagators(textPropagators: propagators, baggagePropagator: baggagePropagator.textMapBaggagePropagator)
    }
}
