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
