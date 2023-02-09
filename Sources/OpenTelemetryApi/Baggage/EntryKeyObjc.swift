//
//  File.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetryApi

public class EntryKeyObjc: NSObject {
    var entryKey: EntryKey
    
    public init(_ entryKey: EntryKey) {
        self.entryKey = entryKey
    }
    
    /// The name of the key
    public var name: String {
        get {
            return self.entryKey.name
        }
    }

    public static func entryKey(_ name: String) -> EntryKeyObjc? {
        let key = EntryKey.init(name: name)
        guard let _ = key else {
            return nil
        }
        
        return EntryKeyObjc(key!)
    }
}
