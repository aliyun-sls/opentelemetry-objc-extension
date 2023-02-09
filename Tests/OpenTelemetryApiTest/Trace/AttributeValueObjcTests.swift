//
//  AttributeValueObjcTests.swift
//  
//
//  Created by gordon on 2023/2/8.
//

@testable import OpenTelemetryApiObjc
@testable import OpenTelemetryApi
import XCTest

class AttributeValueObjcTests: XCTestCase {
    func testAttributeValueObjc_Equals() {
        XCTAssertEqual(AttributeValueObjc.string("string value").attributeValue, AttributeValue.string("string value"))
        XCTAssertNotEqual(AttributeValueObjc.string("string value").attributeValue, AttributeValue.string("string value 1"))
        
        XCTAssertEqual(AttributeValueObjc.bool(true).attributeValue, AttributeValue.bool(true))
        XCTAssertNotEqual(AttributeValueObjc.bool(true).attributeValue, AttributeValue.bool(false))
        
        XCTAssertEqual(AttributeValueObjc.int(11).attributeValue, AttributeValue.int(11))
        XCTAssertNotEqual(AttributeValueObjc.int(11).attributeValue, AttributeValue.int(22))
        
        XCTAssertEqual(AttributeValueObjc.double(1.1).attributeValue, AttributeValue.double(1.1))
        XCTAssertNotEqual(AttributeValueObjc.double(1.1).attributeValue, AttributeValue.double(2.2))
        
        XCTAssertEqual(AttributeValueObjc.stringArray(["1", "2"]).attributeValue, AttributeValue.stringArray(["1", "2"]))
        XCTAssertNotEqual(AttributeValueObjc.stringArray(["1", "2"]).attributeValue, AttributeValue.stringArray(["2", "1"]))
        
        XCTAssertEqual(AttributeValueObjc.intArray([1, 2]).attributeValue, AttributeValue.intArray([1, 2]))
        XCTAssertNotEqual(AttributeValueObjc.intArray([1, 2]).attributeValue, AttributeValue.intArray([2, 1]))
        
        XCTAssertEqual(AttributeValueObjc.doubleArray([1.1, 2.2]).attributeValue, AttributeValue.doubleArray([1.1, 2.2]))
        XCTAssertNotEqual(AttributeValueObjc.doubleArray([1.1, 2.2]).attributeValue, AttributeValue.doubleArray([2.2, 1.1]))
    }
}
