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
