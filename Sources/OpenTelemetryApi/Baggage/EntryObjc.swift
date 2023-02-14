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
