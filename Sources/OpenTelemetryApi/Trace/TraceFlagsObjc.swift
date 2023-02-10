//
//  File.swift
//  
//
//  Created by gordon on 2023/2/10.
//

import Foundation
import OpenTelemetryApi

public class TraceFlagsObjc: NSObject {
    public private(set) var traceFlags: TraceFlags
    
    public init(_ traceFlags: TraceFlags) {
        self.traceFlags = traceFlags
    }
    

    /// Returns the lowercase base16 encoding of this TraceFlags
    @objc
    public var hexString: String {
        return traceFlags.hexString
    }


    /// A boolean indicating whether this Span  is part of a sampled trace and data
    /// should be exported to a persistent store.
    @objc
    public var sampled: Bool {
        return traceFlags.sampled
    }

    /// Sets the sampling bit in the options.
    /// - Parameter isSampled: the sampling bit
    @objc
    public func setIsSampled(_ isSampled: Bool) {
        traceFlags.setIsSampled(isSampled)
    }

    /// Sets the sampling bit in the options.
    /// - Parameter isSampled: the sampling bit
    @objc
    public func settingIsSampled(_ isSampled: Bool) -> TraceFlagsObjc {
        return TraceFlagsObjc(traceFlags.settingIsSampled(isSampled))
    }

    @objc
    public override var description: String {
        traceFlags.description
    }
}
