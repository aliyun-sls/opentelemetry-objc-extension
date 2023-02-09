//
//  File.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetryApi

public class EntryMetadataObjc: NSObject {
    var entryMetadata: EntryMetadata
    
    @objc
    public var metadat: String {
        get {
            return entryMetadata.metadata
        }
    }
    
    public init(_ entryMetadata: EntryMetadata) {
        self.entryMetadata = entryMetadata
    }
    
    @objc
    public static func entryMetadata(_ metadata: String?) -> EntryMetadataObjc? {
        let data = EntryMetadata.init(metadata: metadata)
        guard let _ = data else {
            return nil
        }
        
        return EntryMetadataObjc(data!)
    }
}
