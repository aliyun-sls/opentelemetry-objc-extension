//
//  File.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetryApi

@objc
public class BaggageObjc: NSObject {
    var baggage: Baggage
    public init(_ baggage: Baggage) {
        self.baggage = baggage
    }
    
    /// Builder for the Baggage class
    @objc
    public static func baggageBuilder() -> BaggageBuilderObjc {
        return BaggageBuilderObjc(OpenTelemetry.instance.baggageManager.baggageBuilder())
    }

    /// Returns an immutable collection of the entries in this Baggage. Order of
    /// entries is not guaranteed.
    @objc
    public func getEntries() -> [EntryObjc] {
        var entries = [EntryObjc]()
        for entry in baggage.getEntries() {
            entries.append(EntryObjc(entry))
        }
        return entries
    }

    ///  Returns the EntryValue associated with the given EntryKey.
    /// - Parameter key: entry key to return the value for.
    @objc
    public func getEntryValue(key: EntryKeyObjc) -> EntryValueObjc? {
        if let value = baggage.getEntryValue(key: key.entryKey) {
            return EntryValueObjc(value)
        }
        
        return nil
    }
    
}
