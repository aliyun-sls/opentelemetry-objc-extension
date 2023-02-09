//
//  File.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetrySdk

public class EnvVarResourceObjc : NSObject {
    
    @objc
    public static let resource = ResourcesObjc(EnvVarResource.resource)
    
    private override init() {}
    
    @objc
    public static func get(environment: Dictionary<String, String> = ProcessInfo.processInfo.environment) -> ResourcesObjc {
        return ResourcesObjc(EnvVarResource.get(environment: environment))
    }
    
}
