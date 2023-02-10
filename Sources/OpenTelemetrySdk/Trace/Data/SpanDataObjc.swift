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

public class SpanDataObjc : NSObject {
    var spanData: SpanData
    
    public init(_ spanData: SpanData) {
        self.spanData = spanData
    }

    /// The trace id for this span.
    @objc
    public var traceId: TraceIdObjc {
        get {
            return TraceIdObjc(spanData.traceId)
        }
    }

    /// The span id for this span.
    @objc
    public var spanId: SpanIdObjc {
        get {
            return SpanIdObjc(spanData.spanId)
        }
    }

    /// The trace flags for this span.
    @objc
    public var traceFlags: TraceFlagsObjc {
        get {
            return TraceFlagsObjc(spanData.traceFlags)
        }
    }

    /// The TraceState for this span.
    @objc public var traceState: TraceStateObjc {
        get {
            return TraceStateObjc(spanData.traceState)
        }
    }

    /// The parent SpanId. If the  Span is a root Span, the SpanId
    /// returned will be nil.
    @objc public var parentSpanId: SpanIdObjc? {
        get {
            guard let _ = spanData.parentSpanId else {
                return nil
            }
            
            return SpanIdObjc(spanData.parentSpanId!)
        }
    }

    /// The resource of this Span.
    @objc public var resource: ResourcesObjc {
        get {
            return ResourcesObjc(spanData.resource)
        }
    }

    /// The instrumentation scope specified when creating the tracer which produced this Span
    @objc public var instrumentationScope: InstrumentationScopeInfoObjc {
        get {
            return InstrumentationScopeInfoObjc(spanData.instrumentationScope)
        }
    }

    /// The name of this Span.
    @objc public var name: String {
        get {
            return spanData.name
        }
    }

    /// The kind of this Span.
    @objc public var kind: SpanKindObjc {
        get {
            return SpanKindObjc(spanData.kind)
        }
    }

    /// The start epoch time in nanos of this Span.
    @objc public var startTime: Date {
        get {
            return spanData.startTime
        }
    }

    /// The attributes recorded for this Span.
    @objc public var attributes: [String: AttributeValueObjc] {
        get {
            var atts = [String: AttributeValueObjc]()
            for attr in spanData.attributes {
                atts.updateValue(AttributeValueObjc(attr.value), forKey: attr.key)
            }
            return atts
        }
    }

    /// The timed events recorded for this Span.
    @objc public var events: [EventObjc] {
        get {
            var ents = [EventObjc]()
            for ent in spanData.events {
                ents.append(EventObjc(ent))
            }
            return ents
        }
    }

    /// The links recorded for this Span.
    @objc public var links: [LinkObjc] {
        get {
            var lks = [LinkObjc]()
            for l in spanData.links {
                lks.append(LinkObjc(l))
            }
            return lks
        }
    }

    /// The Status.
    @objc public var status: StatusObjc {
        get {
            return StatusObjc(spanData.status)
        }
    }

    /// The end epoch time in nanos of this Span
    @objc public var endTime: Date {
        get {
            return spanData.endTime
        }
    }

    /// True if the parent is on a different process, false if this is a root span.
    @objc public var hasRemoteParent: Bool {
        get {
            return spanData.hasRemoteParent
        }
    }

    /// True if the span has already been ended, false if not.
    @objc public var hasEnded: Bool {
        get {
            return spanData.hasEnded
        }
    }

    /// The total number of {@link TimedEvent} events that were recorded on this span. This
    /// number may be larger than the number of events that are attached to this span, if the total
    /// number recorded was greater than the configured maximum value. See SpanLimits.maxNumberOfEvents
    @objc public var totalRecordedEvents: Int {
        get {
            return spanData.totalRecordedEvents
        }
    }

    /// The total number of  links that were recorded on this span. This number
    /// may be larger than the number of links that are attached to this span, if the total number
    /// recorded was greater than the configured maximum value. See SpanLimits.maxNumberOfLinks
    @objc public var totalRecordedLinks: Int {
        get {
            return spanData.totalRecordedLinks
        }
    }

    /// The total number of attributes that were recorded on this span. This number may be larger than
    /// the number of attributes that are attached to this span, if the total number recorded was
    /// greater than the configured maximum value. See SpanLimits.maxNumberOfAttributes
    @objc public var totalAttributeCount: Int {
        get {
            return spanData.totalAttributeCount
        }
    }

    @discardableResult public func settingName(_ name: String) -> SpanDataObjc {
        spanData.settingName(name)
        return self
    }

    @discardableResult public func settingTraceId(_ traceId: TraceIdObjc) -> SpanDataObjc {
        spanData.settingTraceId(traceId.traceId)
        return self
    }

    @discardableResult public func settingSpanId(_ spanId: SpanIdObjc) -> SpanDataObjc {
        spanData.settingSpanId(spanId.spanId)
        return self
    }

    @discardableResult public func settingTraceFlags(_ traceFlags: TraceFlagsObjc) -> SpanDataObjc {
        spanData.settingTraceFlags(traceFlags.traceFlags)
        return self
    }

    @discardableResult public func settingTraceState(_ traceState: TraceStateObjc) -> SpanDataObjc {
        spanData.settingTraceState(traceState.traceState)
        return self
    }

    @discardableResult public func settingAttributes(_ attributes: [String: AttributeValueObjc]) -> SpanDataObjc {
        var attrs = [String: AttributeValue]()
        for attr in attributes {
            attrs.updateValue(attr.value.attributeValue, forKey: attr.key)
        }
        spanData.settingAttributes(attrs)
        return self
    }

    @discardableResult public func settingStartTime(_ time: Date) -> SpanDataObjc {
        spanData.settingStartTime(time)
        return self
    }

    @discardableResult public func settingEndTime(_ time: Date) -> SpanDataObjc {
        spanData.settingEndTime(time)
        return self
    }

    @discardableResult public func settingKind(_ kind: SpanKindObjc) -> SpanDataObjc {
        spanData.settingKind(kind.spanKind)
        return self
    }

    @discardableResult public func settingLinks(_ links: [LinkObjc]) -> SpanDataObjc {
        var lks = [SpanData.Link]()
        for l in links {
            lks.append(l.link)
        }
        
        spanData.settingLinks(lks)
        return self
    }

    @discardableResult public func settingParentSpanId(_ parentSpanId: SpanIdObjc) -> SpanDataObjc {
        spanData.settingParentSpanId(parentSpanId.spanId)
        return self
    }

    @discardableResult public func settingResource(_ resource: ResourcesObjc) -> SpanDataObjc {
        spanData.settingResource(resource.resource)
        return self
    }

    @discardableResult public func settingStatus(_ status: StatusObjc) -> SpanDataObjc {
        spanData.settingStatus(status.status)
        return self
    }

    @discardableResult public func settingEvents(_ events: [EventObjc]) -> SpanDataObjc {
        var ents = [SpanData.Event]()
        for evt in events {
            ents.append(evt.event)
        }
        spanData.settingEvents(ents)
        return self
    }

    @discardableResult public func settingHasRemoteParent(_ hasRemoteParent: Bool) -> SpanDataObjc {
        spanData.settingHasRemoteParent(hasRemoteParent)
        return self
    }

    @discardableResult public func settingHasEnded(_ hasEnded: Bool) -> SpanDataObjc {
        spanData.settingHasEnded(hasEnded)
        return self
    }

    @discardableResult public func settingTotalRecordedEvents(_ totalRecordedEvents: Int) -> SpanDataObjc {
        spanData.settingTotalRecordedEvents(totalRecordedEvents)
        return self
    }

    @discardableResult public func settingTotalRecordedLinks(_ totalRecordedLinks: Int) -> SpanDataObjc {
        spanData.settingTotalRecordedLinks(totalRecordedLinks)
        return self
    }

    @discardableResult public func settingTotalAttributeCount(_ totalAttributeCount: Int) -> SpanDataObjc {
        spanData.settingTotalAttributeCount(totalAttributeCount)
        return self
    }
    
    @objc
    public class LinkObjc: NSObject {
        var link: SpanData.Link
        
        public init(_ link: SpanData.Link) {
            self.link = link
        }
    }
    
    @objc
    public class EventObjc: NSObject {
        public private(set) var event: SpanData.Event
        
        public var timestamp: Date {
            get {
                return event.timestamp
            }
        }
        public var name: String {
            get {
                return event.name
            }
        }
        public var attributes: [String: AttributeValueObjc] {
            get {
                var attrs = [String: AttributeValueObjc]()
                for attr in event.attributes {
                    attrs.updateValue(AttributeValueObjc(attr.value), forKey: attr.key)
                }
                return attrs
            }
        }
        
        public init(_ event: SpanData.Event) {
            self.event = event
        }
        
        /// Creates an Event with the given time, name and empty attributes.
        /// - Parameters:
        ///   - nanotime: epoch time in nanos.
        ///   - name: the name of this Event.
        ///   - attributes: the attributes of this Event. Empty by default.
        @objc
        public static func event(_ name: String, timestamp: Date, attributes: [String: AttributeValueObjc]? = nil) -> EventObjc {
            var attrs: [String: AttributeValue]? = [String: AttributeValue]()
            if let _ = attributes {
                for attr in attributes! {
                    attrs?.updateValue(attr.value.attributeValue, forKey: attr.key)
                }
            }
            return EventObjc(SpanData.Event(name: name, timestamp: timestamp, attributes: attrs))
        }

        /// Creates an Event with the given time and event.
        /// - Parameters:
        ///   - nanotime: epoch time in nanos.
        ///   - event: the event.
        public static func event(_ timestamp: Date, event: EventObjc) -> EventObjc{
            return EventObjc(SpanData.Event(timestamp: timestamp, event: event.event))
        }
    }
}
