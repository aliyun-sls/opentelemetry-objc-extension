//
//  File.swift
//  
//
//  Created by gordon on 2023/2/8.
//

import Foundation
import OpenTelemetryApi

public class AttributeValueObjc : NSObject {

    public private(set) var attributeValue: AttributeValue
    
    public init(_ attributeValue: AttributeValue) {
        self.attributeValue = attributeValue
    }
        
    @objc
    public static func string(_ value: String)-> AttributeValueObjc {
        return AttributeValueObjc(AttributeValue.string(value))
    }
    
    @objc
    public static func bool(_ value: Bool)-> AttributeValueObjc {
        return AttributeValueObjc(AttributeValue.bool(value))
    }
    
    @objc
    public static func int(_ value: Int)-> AttributeValueObjc {
        return AttributeValueObjc(AttributeValue.int(value))
    }
    
    @objc
    public static func double(_ value: Double)-> AttributeValueObjc {
        return AttributeValueObjc(AttributeValue.double(value))
    }
    
    @objc
    public static func stringArray(_ value: Array<String>)-> AttributeValueObjc {
        var array = [String]()
        for str in value {
            array.append(str)
        }
        return AttributeValueObjc(AttributeValue.stringArray(array))
    }
    
    @objc
    public static func intArray(_ value: Array<Int>)-> AttributeValueObjc {
        var array = [Int]()
        for str in value {
            array.append(str)
        }
        return AttributeValueObjc(AttributeValue.intArray(array))
    }
    
    @objc
    public static func doubleArray(_ value: Array<Double>)-> AttributeValueObjc {
        var array = [Double]()
        for str in value {
            array.append(str)
        }
        return AttributeValueObjc(AttributeValue.doubleArray(array))
    }

    @objc
    public override var description: String {
        return attributeValue.description
    }
}
