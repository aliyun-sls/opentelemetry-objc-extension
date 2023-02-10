//
//  OtlpConfigurationObjc.swift
//  
//
//  Created by gordon on 2023/2/8.
//

import Foundation

import OpenTelemetryProtocolExporter

//@objcMembers
public class OtlpConfigurationObjc : NSObject {
    @objc
    public static let DefaultTimeoutInterval : TimeInterval = OtlpConfiguration.DefaultTimeoutInterval
    
    var otlpConfiguration : OtlpConfiguration
    
    @objc
    public init(timeout: TimeInterval = DefaultTimeoutInterval, headers: Dictionary<String, String>? = nil) {
        var headersDict: [(String, String)]?
        
        if let _ = headers {
            headersDict = [(String, String)]()
            
            for (k, v) in headers! {
                headersDict?.append((k, v))
            }
        }
        
        otlpConfiguration = OtlpConfiguration(timeout: timeout, headers: headersDict)
    }
    
    @objc
    public static func configuration(_ timeout: TimeInterval = DefaultTimeoutInterval, headers: Dictionary<String, String>? = nil) -> OtlpConfigurationObjc {
        return OtlpConfigurationObjc(timeout: timeout, headers: headers)
    }
    
    @objc
    public static func configuration(headers: Dictionary<String, String>? = nil) -> OtlpConfigurationObjc {
        return configuration(DefaultTimeoutInterval, headers: headers)
    }
}
