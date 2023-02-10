//
//  File.swift
//  
//
//  Created by gordon on 2023/2/10.
//

import Foundation
import ResourceExtension
import OpenTelemetrySdkObjc

public class DefaultResourcesObjc: NSObject {
    public private(set) var defaultResources: DefaultResources
    
    public init(_ defaultResources: DefaultResources) {
        self.defaultResources = defaultResources
    }
    
    public func get() -> ResourceObjc {
        return ResourceObjc(defaultResources.get())
    }
}
