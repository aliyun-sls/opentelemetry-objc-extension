//
//  ResourceObjc.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetryApi
import OpenTelemetryApiObjc
import OpenTelemetrySdk

public class ResourceObjc : NSObject {
    var resource: Resource
    
    @objc
    public static var empty: ResourceObjc {
        return ResourceObjc(attributes: Dictionary())
    }
    
    @objc
    public var attributes: [String: AttributeValueObjc] {
        var attr: [String: AttributeValueObjc] = [String: AttributeValueObjc]()
        for kv in resource.attributes {
            attr.updateValue(AttributeValueObjc(kv.value), forKey: kv.key)
        }
        return attr
    }

    public init(_ resource: Resource) {
        self.resource = resource;
    }
    
    public convenience init(attributes: Dictionary<String, AttributeValueObjc>) {
        var attrs = [String: AttributeValue]()
        
        for kv in attributes {
            attrs.updateValue(kv.value.attributeValue, forKey: kv.key)
        }
        
        self.init(Resource(attributes: attrs))
    }
    
    @objc
    public static func resource(_ attributes: Dictionary<String, AttributeValueObjc>) -> ResourceObjc {
        return ResourceObjc(attributes: attributes)
    }
    
    @objc
    public func merge(_ other: ResourceObjc) {
        resource.attributes.merge(other.resource.attributes) { _, other in other }
    }
    
    public func merging(_ other: ResourceObjc) -> ResourceObjc {
        return ResourceObjc(other.resource)
    }

}
