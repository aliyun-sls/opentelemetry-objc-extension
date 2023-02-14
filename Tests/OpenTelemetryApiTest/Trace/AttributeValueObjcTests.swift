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
