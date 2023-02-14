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
