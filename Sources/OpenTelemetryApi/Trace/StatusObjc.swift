//
//  File.swift
//  
//
//  Created by gordon on 2023/2/8.
//

import Foundation
import OpenTelemetryApi

public class StatusObjc : NSObject {
    var status: Status
    
    public static var OK: StatusObjc {
        return StatusObjc(.ok)
    }
    
    public static var UNSET: StatusObjc {
        return StatusObjc(.unset)
    }
    
    public static var ERROR: StatusObjc {
        return StatusObjc(.error(description: ""))
    }
    
    
    public var isOk: Bool {
        return status.isOk
    }

    /// True if this Status is an Error
    public var isError: Bool {
        return status.isError
    }

    public var name: String {
        return status.name
    }

    public var code: Int {
        return status.code
    }
    
    
    init(_ status: Status) {
        self.status = status
    }
    
    
}
