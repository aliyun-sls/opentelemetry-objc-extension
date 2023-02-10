//
//  File.swift
//  
//
//  Created by gordon on 2023/2/10.
//

import Foundation
import OpenTelemetryApi

public class EntryObjc: NSObject {
    var entry: Entry
    
    public init(_ entry: Entry) {
        self.entry = entry
    }
    
    
    /// The entry key.
    public var key: EntryKeyObjc {
        get {
            return EntryKeyObjc(entry.key)
        }
    }

    /// The entry value.
    public var value: EntryValueObjc {
        get {
            return EntryValueObjc(entry.value)
        }
    }

    /// The entry metadata.
    public var metadata: EntryMetadataObjc? {
        get {
            guard let _ = entry.metadata else {
                return nil
            }
            
            return EntryMetadataObjc(entry.metadata!)
        }
    }

    /// Creates an Entry from the given key, value and metadata.
    /// - Parameters:
    ///   - key: the entry key.
    ///   - value: the entry value.
    ///   - entryMetadata: the entry metadata.
    public convenience init(key: EntryKeyObjc, value: EntryValueObjc, metadata: EntryMetadataObjc?) {
        self.init(Entry(key: key.entryKey, value: value.entryValue, metadata: metadata?.entryMetadata))
    }

}
