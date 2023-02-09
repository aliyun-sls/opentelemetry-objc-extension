//
//  File.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetryApi

public class BaggageManagerObjc: NSObject {
    var baggageManager: BaggageManager
    
    public init(_ baggageManager: BaggageManager) {
        self.baggageManager = baggageManager
    }
    
    /// Returns a new ContextBuilder.
    @objc
    public func baggageBuilder() -> BaggageBuilderObjc {
        return BaggageBuilderObjc(baggageManager.baggageBuilder())
    }
}
