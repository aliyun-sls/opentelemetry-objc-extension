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

@objc
public protocol ClockImpl {
    var now: Date { get }
    var nanoTime: UInt64 { get }
}

public class ClockObjc : NSObject {
    var clock: Clock
    
    private init(_ clock: Clock) {
        self.clock = clock
    }
    
    @objc
    public static func clock(_ clock: ClockImpl) -> ClockObjc {
        return ClockObjc(InternalClock(clock))
    }
}

fileprivate class InternalClock : Clock {
    var impl : ClockImpl
    
    public init(_ impl: ClockImpl) {
        self.impl = impl
    }
    
    public var now: Date {
        return impl.now
    }
    
    public var nanoTime: UInt64 {
        return impl.nanoTime
    }
    
}
