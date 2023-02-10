//
//  File.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetryApi

public class TextMapBaggagePropagatorObjc: NSObject {
    var textMapBaggagePropagator: TextMapBaggagePropagator
    
    public init(_ textMapBaggagePropagator: TextMapBaggagePropagator) {
        self.textMapBaggagePropagator = textMapBaggagePropagator
    }
    
    var fields: Set<String> {
        get {
            return textMapBaggagePropagator.fields
        }
    }
    
    /// Injects textual representation of span context to transmit over the wire.
    /// - Parameters:
    ///   - spanContext: Span context to transmit over the wire.
    ///   - carrier: Object to set context on. Instance of this object will be passed to setter.
    ///   - setter: Action that will set name and value pair on the object.
    @objc
    public func inject(_ baggage: BaggageObjc, carrier: NSMutableDictionary, setter: SetterImpl) {
        var dict: Dictionary<String, String> = Dictionary<String, String>()
        textMapBaggagePropagator.inject(baggage: baggage.baggage, carrier: &dict, setter: InternalSetter(setter, carrier: carrier))
    }

    /// Extracts span context from textual representation.
    /// - Parameters:
    ///   - carrier: Object to extract context from. Instance of this object will be passed to the getter.
    ///   - getter: Function that will return string value of a key with the specified name.
    @objc
    @discardableResult func extract(_ carrier: [String: String], getter: GetterImpl) -> BaggageObjc? {
        if let baggage = textMapBaggagePropagator.extract(carrier: carrier, getter: InternalGetter(getter)) {
            return BaggageObjc(baggage)
        }
        
        return nil
    }
    
    @objc
    public static func propagator(_ impl: TextMapBaggagePropagatorImpl) -> TextMapBaggagePropagatorObjc {
        return TextMapBaggagePropagatorObjc(TextMapBaggagePropagatorWrapper(impl))
    }
}

@objc
public protocol TextMapBaggagePropagatorImpl {
    /// Gets the list of headers used by propagator.
    var fields: Set<String> { get }

    /// Injects textual representation of span context to transmit over the wire.
    /// - Parameters:
    ///   - spanContext: Span context to transmit over the wire.
    ///   - carrier: Object to set context on. Instance of this object will be passed to setter.
    ///   - setter: Action that will set name and value pair on the object.
    func inject(_ baggage: BaggageObjc, carrier: NSMutableDictionary, setter: SetterImpl)

    /// Extracts span context from textual representation.
    /// - Parameters:
    ///   - carrier: Object to extract context from. Instance of this object will be passed to the getter.
    ///   - getter: Function that will return string value of a key with the specified name.
    @discardableResult func extract(_ carrier: [String: String], getter: GetterImpl) -> BaggageObjc?
}

fileprivate class TextMapBaggagePropagatorWrapper: TextMapBaggagePropagator {
    var impl: TextMapBaggagePropagatorImpl

    var fields: Set<String> {
        get {
            return impl.fields
        }
    }

    public init(_ impl: TextMapBaggagePropagatorImpl) {
        self.impl = impl
    }

    func inject<S>(baggage: Baggage, carrier: inout [String : String], setter: S) where S : Setter {
        let set = setter as! InternalSetter
        impl.inject(BaggageObjc(baggage), carrier: set.carrier, setter: set.impl)
    }

    func extract<G>(carrier: [String : String], getter: G) -> Baggage? where G : Getter {
        return impl.extract(carrier, getter: (getter as! InternalGetter).impl)?.baggage
    }
}
