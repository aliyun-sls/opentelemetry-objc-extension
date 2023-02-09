//
//  File.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetryApi

/// Builder for the Baggage class
public class BaggageBuilderObjc: NSObject {
    var baggageBuilder: BaggageBuilder
    
    public init(_ baggabeBuilder: BaggageBuilder) {
        self.baggageBuilder = baggabeBuilder
    }
    
    
    ///  Sets the parent Baggage to use. If no parent is provided, the value of
    ///  BaggageManager.getCurrentContext() at build() time will be used
    ///  as parent, unless setNoParent() was called.
    ///  This must be used to create a Baggage when manual Context
    ///  propagation is used.
    ///  If called multiple times, only the last specified value will be used.
    /// - Parameter parent: the Baggage used as parent
    @objc
    @discardableResult func setParent(_ parent: BaggageObjc?) -> Self {
        baggageBuilder.setParent(parent?.baggage)
        return self
    }

    /// Sets the option to become a root Baggage with no parent. If not
    /// called, the value provided using setParent(Baggage) or otherwise
    /// BaggageManager.getCurrentContext()} at build() time will be used as
    /// parent.
    @objc
    @discardableResult func setNoParent() -> Self {
        baggageBuilder.setNoParent()
        return self
    }

    /// Adds the key/value pair and metadata regardless of whether the key is present.
    /// - Parameters:
    ///   - key: the EntryKey which will be set.
    ///   - value: the EntryValue to set for the given key.
    ///   - metadata: the EntryMetadata associated with this Entry.
    @objc
    @discardableResult func put(key: EntryKeyObjc, value: EntryValueObjc, metadata: EntryMetadataObjc?) -> Self {
        baggageBuilder.put(key: key.entryKey, value: value.entryValue, metadata: metadata?.entryMetadata)
        return self
    }

    /// Removes the key if it exists.
    /// - Parameter key: the EntryKey which will be removed.
    
    @objc
    @discardableResult func remove(key: EntryKeyObjc) -> Self {
        baggageBuilder.remove(key: key.entryKey)
        return self
    }

    /// Creates a Baggage from this builder.
    func build() -> BaggageObjc {
        return BaggageObjc(baggageBuilder.build())
    }
}
