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

public class TraceStateObjc: NSObject {
    public private(set) var traceState: TraceState
    
    public init(_ traceState: TraceState) {
        self.traceState = traceState
    }
    
    public var entries: [TraceStateObjc.EntryObjc] {
        get {
            var objcs = [TraceStateObjc.EntryObjc]()
            for entry in traceState.entries {
                objcs.append(TraceStateObjc.EntryObjc(entry))
            }
            
            return objcs
        }
    }
    
    /// Returns the value to which the specified key is mapped, or nil if this map contains no mapping
    ///  for the key
    /// - Parameter key: key with which the specified value is to be associated
    public func get(key: String) -> String? {
        return traceState.get(key: key)
    }
    
    
    /// Returns a copy the traceState by appending the Entry that has the given key if it is present.
    /// The new Entry will always be added in the front of the existing list of entries.
    /// - Parameters:
    ///   - key: the key for the Entry to be added.
    ///   - value: the value for the Entry to be added.
    public func setting(key: String, value: String) -> Self {
        _ = traceState.setting(key: key, value: value)
        return self
    }
    
    /// Returns a copy the traceState by removinf the Entry that has the given key if it is present.
    /// - Parameter key: the key for the Entry to be removed.
    public func removing(key: String) -> TraceStateObjc {
        return TraceStateObjc(traceState.removing(key: key))
    }
    
    public class EntryObjc: NSObject {
        var entry: TraceState.Entry
        
        /// The key of the Entry
        @objc
        public var key: String {
            get {
                return entry.key
            }
        }
        
        /// The value of the Entry
        @objc
        public var value: String {
            get {
                return entry.value
            }
        }
        
        public init(_ entry: TraceState.Entry) {
            self.entry = entry
        }
    }
}
