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
    func inject(spanContext: SpanContextObjc, carrier: [String: String], setter: SetterImpl) {
        var dict: [String: String] = [String: String]()
        textMapPropagator.inject(spanContext: spanContext.spanContext, carrier: &dict, setter: InternalSetter(setter))
    }

    /// Extracts span context from textual representation.
    /// - Parameters:
    ///   - carrier: Object to extract context from. Instance of this object will be passed to the getter.
    ///   - getter: Function that will return string value of a key with the specified name.
    @discardableResult func extract(carrier: [String: String], getter: GetterImpl) -> SpanContextObjc? {
        if let ctx = textMapPropagator.extract(carrier: carrier, getter: InternalGetter(getter)) {
            return SpanContextObjc(ctx)
        }
        
        return nil
    }
    
    @objc
    public static func propagator(_ textMapPropagator: TextMapPropagatorImpl,_ setter: SetterImpl, _ getter: GetterImpl) -> TextMapPropagatorObjc {
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
        impl.inject(SpanContextObjc(spanContext), carrier: carrier, setter: (setter as! InternalSetter).impl)
    }

    func extract<G>(carrier: [String : String], getter: G) -> SpanContext? where G : Getter {
        return impl.extract(carrier, getter: (getter as! InternalGetter).impl)?.spanContext
    }
}

public class InternalSetter: Setter {
    public var impl: SetterImpl
    public init(_ impl: SetterImpl) {
        self.impl = impl
    }
    
    public func set(carrier: inout [String : String], key: String, value: String) {
        impl.set(carrier: carrier, key: key, value: value)
    }
}

public class InternalGetter: Getter {
    var impl: GetterImpl
    
    public init(_ impl: GetterImpl) {
        self.impl = impl
    }
    
    public func get(carrier: [String : String], key: String) -> [String]? {
        return impl.get(carrier: carrier, key: key)
    }
    
}

@objc
public protocol SetterImpl {
    /// - Parameters:
    ///   - carrier:  Object to set context on.
    ///   - key: Name of the value to set.
    ///   - value: Value to set.
    func set(carrier: [String: String], key: String, value: String)
}

@objc
public protocol GetterImpl {
    /// - Parameters:
    ///   - carrier: Object to extract context from.
    ///   - key: Name of the value to extract.
    func get(carrier: [String: String], key: String) -> [String]?
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
    func inject(_ spanContext: SpanContextObjc, carrier: [String: String], setter: SetterImpl)

    /// Extracts span context from textual representation.
    /// - Parameters:
    ///   - carrier: Object to extract context from. Instance of this object will be passed to the getter.
    ///   - getter: Function that will return string value of a key with the specified name.
    @discardableResult func extract(_ carrier: [String: String], getter: GetterImpl) -> SpanContextObjc?
}
