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

public class TraceFlagsObjc: NSObject {
    public private(set) var traceFlags: TraceFlags
    
    public init(_ traceFlags: TraceFlags) {
        self.traceFlags = traceFlags
    }
    

    /// Returns the lowercase base16 encoding of this TraceFlags
    @objc
    public var hexString: String {
        return traceFlags.hexString
    }


    /// A boolean indicating whether this Span  is part of a sampled trace and data
    /// should be exported to a persistent store.
    @objc
    public var sampled: Bool {
        return traceFlags.sampled
    }

    /// Sets the sampling bit in the options.
    /// - Parameter isSampled: the sampling bit
    @objc
    public func setIsSampled(_ isSampled: Bool) {
        traceFlags.setIsSampled(isSampled)
    }

    /// Sets the sampling bit in the options.
    /// - Parameter isSampled: the sampling bit
    @objc
    public func settingIsSampled(_ isSampled: Bool) -> TraceFlagsObjc {
        return TraceFlagsObjc(traceFlags.settingIsSampled(isSampled))
    }

    @objc
    public override var description: String {
        traceFlags.description
    }
}
