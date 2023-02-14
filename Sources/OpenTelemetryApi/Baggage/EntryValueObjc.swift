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
