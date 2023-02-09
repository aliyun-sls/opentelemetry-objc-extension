//
//  File.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetryApi

public class EntryValueObjc: NSObject {
    var entryValue: EntryValue
    
    public init(_ entryValue: EntryValue) {
        self.entryValue = entryValue
    }

    /// The entry value as String
    @objc
    public var string: String  {
        get {
            return entryValue.string
        }
    }
    
    @objc
    public static func entryValue(_ string: String) -> EntryValueObjc? {
        let value = EntryValue.init(string: string)
        guard let _ = value else {
            return nil
        }
        
        return EntryValueObjc(value!)
    }
}
