//
//  File.swift
//  
//
//  Created by gordon on 2023/2/8.
//

import Foundation
import OpenTelemetryApi

public class SpanBuilderObjc : NSObject {
    var spanBuilder : SpanBuilder
    
    public init(_ spanBuilder: SpanBuilder) {
        self.spanBuilder = spanBuilder
    }
    
    /// Sets the parent Span to use. If not set, the value of OpenTelemetryContext.activeSpan
    /// at startSpan() time will be used as parent.
    ///
    /// This must be used to create a Span when manual Context propagation is used
    /// OR when creating a root Span with a parent with an invalid SpanContext.
    ///
    /// Observe this is the preferred method when the parent is a Span created within the
    /// process. Using its SpanContext as parent remains as a valid, albeit inefficient,
    /// operation.
    ///
    /// If called multiple times, only the last specified value will be used. Observe that the
    /// state defined by a previous call to setNoParent() will be discarded.
    ///
    /// - Parameter parent: the Span used as parent.
    @objc
    public func setParent(_ parent: SpanObjc) -> Self {
        spanBuilder.setParent(parent.span)
        return self;
    }

    /// Sets the parent SpanContext to use. If not set, the value of
    /// OpenTelemetryContext.activeSpan at startSpan() time will be used as parent.
    ///
    /// Similar to setParent(Span parent) but this must be used to create a
    /// Span when the parent is in a different process. This is only intended for use by RPC systems
    /// or similar.
    ///
    /// If no SpanContext is available, users must call setNoParent in order to
    /// create a root Span for a new trace.
    ///
    /// If called multiple times, only the last specified value will be used. Observe that the
    /// state defined by a previous call to setNoParent() will be discarded.
    ///
    /// - Parameter parent: the SpanContext used as parent.
    @objc
    public func setParent(context: SpanContextObjc) -> Self {
        spanBuilder.setParent(context.spanContext)
        return self;
    }

    /// Sets the option to become a root Span for a new trace. If not set, the value of
    /// OpenTelemetryContext.activeSpan at startSpan() time will be used as parent.
    ///
    /// Observe that any previously set parent will be discarded.
    @objc
    public func setNoParent() -> Self {
        spanBuilder.setNoParent()
        return self;
    }

    /// Adds a Link to the newly created Span.
    ///
    /// - Parameter spanContext: the context of the linked Span
    @objc
    public func addLink(_ spanContext: SpanContextObjc) -> Self {
        spanBuilder.addLink(spanContext: spanContext.spanContext)
        return self;
    }

    /// Adds a Link to the newly created Span.
    /// - Parameters:
    ///   - spanContext: the context of the linked Span
    ///   - attributes: the attributes of the Link
    @objc
    public func addLink(_ spanContext: SpanContextObjc, attributes: Dictionary<String, AttributeValueObjc>) -> Self {
        var attrs: [String: AttributeValue] = [String: AttributeValue]()
        for (k, v) in attributes {
            attrs.updateValue(v.attributeValue, forKey: k)
        }
        
        spanBuilder.addLink(spanContext: spanContext.spanContext, attributes: attrs)
        return self;
    }

    /// Sets an attribute to the newly created Span. If SpanBuilder previously
    /// contained a mapping for the key, the old value is replaced by the specified value.
    /// - Parameters:
    ///   - key: the key for this attribute
    ///   - value: the value for this attribute
    @objc
    public func setAttribute(_ key: String, stringValue: String) -> Self {
        spanBuilder.setAttribute(key: key, value: stringValue)
        return self;
    }

    /// Sets an attribute to the newly created Span. If SpanBuilder previously
    /// contained a mapping for the key, the old value is replaced by the specified value.
    /// - Parameters:
    ///   - key: the key for this attribute
    ///   - value: the value for this attribute
    @objc
    public func setAttribute(_ key: String, intValue: Int) -> Self {
        spanBuilder.setAttribute(key: key, value: intValue)
        return self;
    }

    /// Sets an attribute to the newly created Span. If SpanBuilder previously
    /// contained a mapping for the key, the old value is replaced by the specified value.
    /// - Parameters:
    ///   - key: the key for this attribute
    ///   - value: the value for this attribute
    @objc
    public func setAttribute(_ key: String, doubleValue: Double) -> Self {
        spanBuilder.setAttribute(key: key, value: doubleValue)
        return self;
    }

    /// Sets an attribute to the newly created Span. If SpanBuilder previously
    /// contained a mapping for the key, the old value is replaced by the specified value.
    /// - Parameters:
    ///   - key: the key for this attribute
    ///   - value: the value for this attribute
    @objc
    public func setAttribute(_ key: String, boolValue: Bool) -> Self {
        spanBuilder.setAttribute(key: key, value: boolValue)
        return self;
    }

    /// Sets an attribute to the newly created Span. If SpanBuilder previously
    /// contained a mapping for the key, the old value is replaced by the specified value.
    /// - Parameters:
    ///   - key: the key for this attribute
    ///   - value: the value for this attribute, pass nil to remove previous value
    @objc
    public func setAttribute(_ key: String, value: AttributeValueObjc) -> Self {
        spanBuilder.setAttribute(key: key, value: value.attributeValue)
        return self;
    }

    /// Sets the Span.Kind for the newly created Span. If not called, the
    /// implementation will provide a default value Span.Kind#INTERNAL.
    /// - Parameter spanKind: the kind of the newly created Span
    @objc
    public func setSpanKind(_ spanKind: SpanKindObjc) -> Self {
        spanBuilder.setSpanKind(spanKind: spanKind.spanKind)
        return self;
    }

    /// Sets an explicit start timestamp for the newly created Span.
    ///
    /// Use this method to specify an explicit start timestamp. If not called, the implementation
    /// will use the timestamp value at #startSpan() time, which should be the default case.
    /// - Parameter startTimestamp: the explicit start timestamp of the newly created Span in nanos since epoch.
    @objc
    public func setStartTime(_ time: Date) -> Self {
        spanBuilder.setStartTime(time: time)
        return self;
    }

    /// Sets the Span as the active Span in the current context when started.
    /// - Parameter active: If the span will be set as the activeSpan
    @objc
    public func setActive(_ active: Bool) -> Self {
        spanBuilder.setActive(active)
        return self;
    }

    /// Starts a new Span.
    ///
    /// Users must manually call Span.end() to end this Span
    ///
    /// Does not install the newly created Span to the current Context.
    @objc
    public func startSpan() -> SpanObjc {
        return SpanObjc(spanBuilder.startSpan())
    }
}
