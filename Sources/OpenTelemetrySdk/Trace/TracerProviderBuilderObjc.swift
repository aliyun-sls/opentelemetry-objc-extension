//
//  TracerProviderBuilderObjc.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetrySdk
import OpenTelemetryApiObjc

public class TracerProviderBuilderObjc : NSObject {
    var tracerProviderBuilder: TracerProviderBuilder
    
    public override init() {
        self.tracerProviderBuilder = TracerProviderBuilder()
    }
    
    @objc
    public static func builder() -> TracerProviderBuilderObjc {
        return TracerProviderBuilderObjc()
    }
    
    public func with(_ clock: ClockObjc) -> Self {
        _ = tracerProviderBuilder.with(clock: clock.clock)
        return self
    }
    
//    public func with(_ idGenerator: IdGeneratorObjc) {
//        return self
//    }
    
    @objc
    public func with(sampler: SamplerObjc) -> Self {
        _ = tracerProviderBuilder.with(sampler: sampler.sampler)
        return self
    }
    
    @objc
    public func with(resource: ResourcesObjc) -> Self {
        _ = tracerProviderBuilder.with(resource: resource.resource)
        return self
    }
    
    @objc
    public func addSpanProcessor(_ spanProcessor: SpanProcessorObjc) -> Self {
        _ = tracerProviderBuilder.add(spanProcessor: spanProcessor.spanProcessor)
        return self
    }
    
    @objc
    public func addSpanProcessors(_ spanProcessors: Array<SpanProcessorObjc>) -> Self {
        var processors = [SpanProcessor]()
        
        for processor in spanProcessors {
            processors.append(processor.spanProcessor)
        }
        
        _ = tracerProviderBuilder.add(spanProcessors: processors)
        return self
    }
    
    @objc
    public func build() -> TracerProviderObjc {
        return TracerProviderObjc(tracerProviderBuilder.build())
    }

}
