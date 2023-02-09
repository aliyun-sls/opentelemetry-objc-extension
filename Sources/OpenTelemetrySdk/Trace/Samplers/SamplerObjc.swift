//
//  File.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetrySdk
import OpenTelemetryApi
import OpenTelemetryApiObjc

@objc
public protocol DecisionImpl {
    /// The sampling decision whether span should be sampled or not.
    var isSampled: Bool { get }

    /// Return tags which will be attached to the span.
    /// These attributes should be added to the span only for root span or when sampling decision
    /// changes from false to true.
    var attributes: Dictionary<String, AttributeValueObjc> { get }
}

@objc
public protocol SamplerImpl {
    /// Called during Span creation to make a sampling decision.
    /// - Parameters:
    ///   - parentContext: the parent span's SpanContext. nil if this is a root span
    ///   - traceId: the TraceId for the new Span. This will be identical to that in
    ///     the parentContext, unless this is a root span.
    ///   - name: he name of the new Span.
    ///   - parentLinks: the parentLinks associated with the new Span.
    func shouldSample(parentContext: SpanContextObjc?,
                      traceId: TraceIdObjc,
                      name: String,
                      kind: SpanKindObjc,
                      attributes: Dictionary<String, AttributeValueObjc>,
                      parentLinks: [SpanDataObjc.LinkObjc]) -> DecisionImpl
    
    var description: String { get }
}

public class SamplerObjc : NSObject {
    var sampler: Sampler
    
    public init(_ sampler: Sampler) {
        self.sampler = sampler
    }
    
    @objc
    public static func sampler(_ sampler: SamplerImpl) -> SamplerObjc {
        return SamplerObjc(InternalSampler(sampler))
    }
    
}

fileprivate class InternalDecision: Decision {
    var isSampled: Bool {
        return decision.isSampled
    }
    
    var attributes: [String : AttributeValue] {
        let attrs = decision.attributes
        var attributes = [String : AttributeValue]()
        for attr in attrs {
            attributes.updateValue(attr.value.attributeValue, forKey: attr.key)
        }
        return attributes
    }
    
    var decision: DecisionImpl
    
    public init(_ decision: DecisionImpl) {
        self.decision = decision
    }
    
}

fileprivate class InternalSampler: Sampler {
    var sampler: SamplerImpl
    
    public init(_ sampler: SamplerImpl) {
        self.sampler = sampler
    }
    
    func shouldSample(parentContext: SpanContext?, traceId: TraceId, name: String, kind: SpanKind, attributes: [String : AttributeValue], parentLinks: [SpanData.Link]) -> Decision {
        var attrs = Dictionary<String, AttributeValueObjc>()
        for kv in attributes {
            attrs.updateValue(AttributeValueObjc(kv.value), forKey: kv.key)
        }
        
        var links = [SpanDataObjc.LinkObjc]()
        for link in parentLinks {
            links.append(SpanDataObjc.LinkObjc(link))
        }
        
        var context: SpanContextObjc? = nil
        if let _ = parentContext {
            context = SpanContextObjc(parentContext!)
        }
        
        let decision = sampler.shouldSample(
            parentContext: context,
            traceId: TraceIdObjc(traceId),
            name: name,
            kind: SpanKindObjc(kind),
            attributes: attrs,
            parentLinks: links
        )
        
        return InternalDecision(decision)
    }
    
    var description: String {
        return sampler.description
    }
}
