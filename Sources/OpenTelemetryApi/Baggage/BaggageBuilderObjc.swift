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
    @discardableResult public func setParent(_ parent: BaggageObjc?) -> Self {
        baggageBuilder.setParent(parent?.baggage)
        return self
    }

    /// Sets the option to become a root Baggage with no parent. If not
    /// called, the value provided using setParent(Baggage) or otherwise
    /// BaggageManager.getCurrentContext()} at build() time will be used as
    /// parent.
    @objc
    @discardableResult public func setNoParent() -> Self {
        baggageBuilder.setNoParent()
        return self
    }

    /// Adds the key/value pair and metadata regardless of whether the key is present.
    /// - Parameters:
    ///   - key: the EntryKey which will be set.
    ///   - value: the EntryValue to set for the given key.
    ///   - metadata: the EntryMetadata associated with this Entry.
    @objc
    @discardableResult public func put(_ key: EntryKeyObjc, value: EntryValueObjc, metadata: EntryMetadataObjc?) -> Self {
        baggageBuilder.put(key: key.entryKey, value: value.entryValue, metadata: metadata?.entryMetadata)
        return self
    }

    /// Removes the key if it exists.
    /// - Parameter key: the EntryKey which will be removed.
    
    @objc
    @discardableResult public func remove(_ key: EntryKeyObjc) -> Self {
        baggageBuilder.remove(key: key.entryKey)
        return self
    }

    /// Creates a Baggage from this builder.
    @objc
    public func build() -> BaggageObjc {
        return BaggageObjc(baggageBuilder.build())
    }
}
