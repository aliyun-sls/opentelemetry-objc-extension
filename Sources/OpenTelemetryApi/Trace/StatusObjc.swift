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

public class StatusObjc : NSObject {
    public private(set) var status: Status
    
    @objc
    public static var OK: StatusObjc {
        return StatusObjc(.ok)
    }
    
    @objc
    public static var UNSET: StatusObjc {
        return StatusObjc(.unset)
    }
    
    @objc
    public static var ERROR: StatusObjc {
        return StatusObjc(.error(description: ""))
    }
    
    
    public var isOk: Bool {
        return status.isOk
    }

    /// True if this Status is an Error
    public var isError: Bool {
        return status.isError
    }

    public var name: String {
        return status.name
    }

    public var code: Int {
        return status.code
    }
    
    
    public init(_ status: Status) {
        self.status = status
    }
    
    @objc
    public static func error(_ description: String) -> StatusObjc {
        return StatusObjc(.error(description: description))
    }
    
}
