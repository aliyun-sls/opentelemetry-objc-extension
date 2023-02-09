//
//  SpanBuilderObjcTests.swift
//  
//
//  Created by gordon on 2023/2/8.
//

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
