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
        guard let set = setter as? InternalSetter else {
            let wrapper = SetterWrapper(setter)
            let dictionary = NSMutableDictionary()
            impl.inject(BaggageObjc(baggage), carrier: dictionary, setter: wrapper)
            for kv in dictionary {
                carrier.updateValue(kv.value as! String, forKey: kv.key as! String)
            }
            return
        }
        
        impl.inject(BaggageObjc(baggage), carrier: set.carrier, setter: set.impl)
    }

    func extract<G>(carrier: [String : String], getter: G) -> Baggage? where G : Getter {
        guard let get = getter as? InternalGetter else {
            let wrapper = GetterWrapper(getter)
            return impl.extract(carrier, getter: wrapper)?.baggage
        }
        
        return impl.extract(carrier, getter: get.impl)?.baggage
    }
}
