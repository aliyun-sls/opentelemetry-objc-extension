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

@testable import OpenTelemetryApiObjc
@testable import OpenTelemetryApi
import XCTest

public class SpanBuilderObjcTests: XCTestCase {
    
    func testSpanBuilder_Equals() {
        let parent = DefaultTracer.instance.spanBuilder(spanName: "parent").startSpan()
        
        let spanBuilder = DefaultTracer.instance.spanBuilder(spanName: "test")
        let spanBuilderObjc = SpanBuilderObjc(spanBuilder)
        XCTAssertNotNil(spanBuilderObjc.spanBuilder)
        
        spanBuilderObjc.setParent(SpanObjc(parent))

        
        
        let span = spanBuilder.startSpan()
        let spanObjc = spanBuilderObjc.startSpan()
        
        XCTAssertEqual("test", span.name)
        XCTAssertEqual(parent.context, span.context)
    }
}
