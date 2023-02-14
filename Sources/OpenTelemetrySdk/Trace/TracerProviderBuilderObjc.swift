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
    public func with(resource: ResourceObjc) -> Self {
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
