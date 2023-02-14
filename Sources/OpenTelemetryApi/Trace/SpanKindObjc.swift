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

public class SpanKindObjc : NSObject {
    public private (set) var spanKind : SpanKind
    
    @objc
    public static var INTERNAL: SpanKindObjc {
        return SpanKindObjc(SpanKind.internal)
    }
    
    @objc
    public static var SERVER: SpanKindObjc {
        return SpanKindObjc(SpanKind.server)
    }
    
    @objc
    public static var CLIENT: SpanKindObjc {
        return SpanKindObjc(SpanKind.client)
    }
    
    @objc
    public static var PRODUCER: SpanKindObjc {
        return SpanKindObjc(SpanKind.producer)
    }
    
    @objc
    public static var CONSUMER: SpanKindObjc {
        return SpanKindObjc(SpanKind.consumer)
    }
    
    
    public init(_ spanKind: SpanKind) {
        self.spanKind = spanKind
    }
}
