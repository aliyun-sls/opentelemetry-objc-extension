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
import OpenTelemetrySdk

public class InstrumentationScopeInfoObjc: NSObject {
    public private(set) var instrumentationScope: InstrumentationScopeInfo
    
    public var name: String {
        get {
            return instrumentationScope.name
        }
    }
    public var version: String? {
        get {
            return instrumentationScope.version
        }
    }
    public var schemaUrl : String? {
        get {
            return instrumentationScope.schemaUrl
        }
    }

    ///  Creates a new instance of InstrumentationScopeInfo.
    ///  - Parameters:
    ///    - name: name of the instrumentation library
    ///    - version: version of the instrumentation library (e.g., "semver:1.0.0"), might be nil
    public static func instrumentationScope(name: String, version: String? = nil, schemaUrl: String? = nil) -> InstrumentationScopeInfoObjc{
        return InstrumentationScopeInfoObjc(InstrumentationScopeInfo(name: name, version: version, schemaUrl: schemaUrl))
    }
    
    public init(_ instrumentationScope: InstrumentationScopeInfo) {
        self.instrumentationScope = instrumentationScope
    }
    
    
}
