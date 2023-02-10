//
//  TextMapPropagatorObjc.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetryApi

public class TextMapPropagatorObjc: NSObject {
    public var textMapPropagator: TextMapPropagator
    
    public init(_ textMapPropagator: TextMapPropagator) {
        self.textMapPropagator = textMapPropagator
    }
    
    /// Gets the list of headers used by propagator.
    public var fields: Set<String> {
        get {
            return textMapPropagator.fields
        }
    }

    /// Injects textual representation of span context to transmit over the wire.
    /// - Parameters:
    ///   - spanContext: Span context to transmit over the wire.
    ///   - carrier: Object to set context on. Instance of this object will be passed to setter.
    ///   - setter: Action that will set name and value pair on the object.
    @objc
    public func inject(_ spanContext: SpanContextObjc, carrier: NSMutableDictionary, setter: SetterImpl) {
        var dict: [String: String] = [String: String]()
        textMapPropagator.inject(spanContext: spanContext.spanContext, carrier: &dict, setter: InternalSetter(setter, carrier: carrier))
    }

    /// Extracts span context from textual representation.
    /// - Parameters:
    ///   - carrier: Object to extract context from. Instance of this object will be passed to the getter.
    ///   - getter: Function that will return string value of a key with the specified name.
    @objc
    @discardableResult public func extract(_ carrier: [String: String], getter: GetterImpl) -> SpanContextObjc? {
        if let ctx = textMapPropagator.extract(carrier: carrier, getter: InternalGetter(getter)) {
            return SpanContextObjc(ctx)
        }
        
        return nil
    }
    
    @objc
    public static func propagator(_ textMapPropagator: TextMapPropagatorImpl) -> TextMapPropagatorObjc {
        return TextMapPropagatorObjc(InternalTextMapPropagatorWrapper(textMapPropagator))
    }
}

fileprivate class InternalTextMapPropagatorWrapper: TextMapPropagator {
    var impl: TextMapPropagatorImpl

    public init(_ impl: TextMapPropagatorImpl) {
        self.impl = impl
    }

    var fields: Set<String> {
        get {
            return impl.fields
        }
    }

    func inject<S>(spanContext: SpanContext, carrier: inout [String : String], setter: S) where S : Setter {
        let set = setter as! InternalSetter
        impl.inject(SpanContextObjc(spanContext), carrier: set.carrier, setter: set.impl)
    }

    func extract<G>(carrier: [String : String], getter: G) -> SpanContext? where G : Getter {
        return impl.extract(carrier, getter: (getter as! InternalGetter).impl)?.spanContext
    }
}

public class InternalSetter: Setter {
    public var impl: SetterImpl
    var carrier: NSMutableDictionary
    public init(_ impl: SetterImpl, carrier: NSMutableDictionary) {
        self.impl = impl
        self.carrier = carrier
    }
    
    public func set(carrier: inout [String : String], key: String, value: String) {
        impl.set(self.carrier, key: key, value: value)
    }
}

public class InternalGetter: Getter {
    var impl: GetterImpl
    
    public init(_ impl: GetterImpl) {
        self.impl = impl
    }
    
    public func get(carrier: [String : String], key: String) -> [String]? {
        return impl.get(carrier, key: key)
    }
}

@objc
public protocol SetterImpl {
    /// - Parameters:
    ///   - carrier:  Object to set context on.
    ///   - key: Name of the value to set.
    ///   - value: Value to set.
    func set(_ carrier: NSMutableDictionary, key: String, value: String)
}

@objc
public protocol GetterImpl {
    /// - Parameters:
    ///   - carrier: Object to extract context from.
    ///   - key: Name of the value to extract.
    func get(_ carrier: [String: String], key: String) -> [String]?
}

@objc
public protocol TextMapPropagatorImpl {
    /// Gets the list of headers used by propagator.
    var fields: Set<String> { get }

    /// Injects textual representation of span context to transmit over the wire.
    /// - Parameters:
    ///   - spanContext: Span context to transmit over the wire.
    ///   - carrier: Object to set context on. Instance of this object will be passed to setter.
    ///   - setter: Action that will set name and value pair on the object.
    func inject(_ spanContext: SpanContextObjc, carrier: NSMutableDictionary, setter: SetterImpl)

    /// Extracts span context from textual representation.
    /// - Parameters:
    ///   - carrier: Object to extract context from. Instance of this object will be passed to the getter.
    ///   - getter: Function that will return string value of a key with the specified name.
    @discardableResult func extract(_ carrier: [String: String], getter: GetterImpl) -> SpanContextObjc?
}
