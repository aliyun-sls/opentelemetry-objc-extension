//
//  File.swift
//  
//
//  Created by gordon on 2023/2/10.
//

import Foundation
import OpenTelemetrySdk

public class InstrumentationScopeInfoObjc: NSObject {
    public private(set) var instrumentationScope: InstrumentationScopeInfo
    
    public var name: String {
        get {
            return instrumentationScope.name
        }
    }
    public var version: String? {
        get {
            return instrumentationScope.version
        }
    }
    public var schemaUrl : String? {
        get {
            return instrumentationScope.schemaUrl
        }
    }

    ///  Creates a new instance of InstrumentationScopeInfo.
    ///  - Parameters:
    ///    - name: name of the instrumentation library
    ///    - version: version of the instrumentation library (e.g., "semver:1.0.0"), might be nil
    public static func instrumentationScope(name: String, version: String? = nil, schemaUrl: String? = nil) -> InstrumentationScopeInfoObjc{
        return InstrumentationScopeInfoObjc(InstrumentationScopeInfo(name: name, version: version, schemaUrl: schemaUrl))
    }
    
    public init(_ instrumentationScope: InstrumentationScopeInfo) {
        self.instrumentationScope = instrumentationScope
    }
    
    
}
