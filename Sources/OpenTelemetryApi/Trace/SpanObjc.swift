//
//  File.swift
//  
//
//  Created by gordon on 2023/2/8.
//

import Foundation
import OpenTelemetryApi

public class SpanObjc : NSObject {
    var span : Span
    
    /// Type of span.
    /// Can be used to specify additional relationships between spans in addition to a parent/child relationship.
    @objc
    public var kind: SpanKindObjc {
        return SpanKindObjc(span.kind)
    }

    /// The span context associated with this Span
    @objc
    public var context: SpanContextObjc {
        return SpanContextObjc(span.context)
    }

    /// Indicates whether this span will be recorded.
    @objc
    public var isRecording: Bool {
        return span.isRecording
    }

    /// The status of the span execution.
    @objc
    public var status: StatusObjc {
        get {
            return StatusObjc(span.status)
        }
        
        set {
            span.status = newValue.status
        }
    }

    /// The name of the Span.
    /// If changed, this will override the name provided via StartSpan method overload.
    /// Upon this update, any sampling behavior based on Span name will depend on the
    /// implementation.
    @objc
    public var name: String {
        get {
            return span.name
        }
        
        set {
            span.name = newValue
        }
    }

    /// Puts a new attribute to the span.
    /// - Parameters:
    ///   - key: Key of the attribute.
    ///   - value: Attribute value.
    
    @objc
    public func setAttribute(_ key: String, value: AttributeValueObjc?) {
        span.setAttribute(key: key, value: value?.attributeValue)
    }
    
    @objc
    public func setAttribute(_ key: String, stringValue: String) {
        span.setAttribute(key: key, value: stringValue)
    }
    
    @objc
    public func setAttribute(_ key: String, intValue: Int) {
        span.setAttribute(key: key, value: intValue)
    }
    
    @objc
    public func setAttribute(_ key: String, doubleValue: Double) {
        span.setAttribute(key: key, value: doubleValue)
    }
    
    @objc
    public func setAttribute(_ key: String, boolValue: Bool) {
        span.setAttribute(key: key, value: boolValue)
    }


    /// Adds an event to the Span
    /// - Parameter name: the name of the event.
    @objc
    public func addEvent(_ name: String) {
        span.addEvent(name: name)
    }

    /// Adds an event to the Span
    /// Use this method to specify an explicit event timestamp. If not called, the implementation
    /// will use the current timestamp value, which should be the default case.
    /// - Parameters:
    ///   - name: the name of the even
    ///   - timestamp: the explicit event timestamp in nanos since epoch
    @objc
    public func addEvent(_ name: String, timestamp: Date) {
        span.addEvent(name: name, timestamp: timestamp)
    }

    /// Adds a single Event with the attributes to the Span.
    /// - Parameters:
    ///   - name: Event name.
    ///   - attributes: Dictionary of attributes name/value pairs associated with the Event
    @objc
    public func addEvent(_ name: String, attributes: Dictionary<String, AttributeValueObjc>) {
        var attr = [String: AttributeValue]()
        for (k, v) in attributes {
            attr.updateValue(v.attributeValue, forKey: k)
        }
        
        span.addEvent(name: name, attributes: attr)
    }

    /// Adds an event to the Span
    /// Use this method to specify an explicit event timestamp. If not called, the implementation
    /// will use the current timestamp value, which should be the default case.
    /// - Parameters:
    ///   - name: the name of the even
    ///   - attributes: Dictionary of attributes name/value pairs associated with the Event
    ///   - timestamp: the explicit event timestamp in nanos since epoch
    @objc
    public func addEvent(_ name: String, attributes: Dictionary<String, AttributeValueObjc>, timestamp: Date) {
        var attrs = [String: AttributeValue]()
        for (k, v) in attributes {
            attrs.updateValue(v.attributeValue, forKey: k)
        }
        
        span.addEvent(name: name, attributes: attrs, timestamp: timestamp)
    }

    /// End the span.
    @objc
    public func end() {
        span.end()
    }

    /// End the span.
    /// - Parameter endOptions: The explicit EndSpanOptions for this span
    @objc
    public func end(time: Date) {
        span.end(time: time)
    }
    
    public init(_ span: Span) {
        self.span = span
    }
}
