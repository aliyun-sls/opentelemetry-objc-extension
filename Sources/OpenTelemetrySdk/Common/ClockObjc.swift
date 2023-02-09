//
//  File.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetrySdk

@objc
public protocol ClockImpl {
    var now: Date { get }
    var nanoTime: UInt64 { get }
}

public class ClockObjc : NSObject {
    var clock: Clock
    
    private init(_ clock: Clock) {
        self.clock = clock
    }
    
    @objc
    public static func clock(_ clock: ClockImpl) -> ClockObjc {
        return ClockObjc(InternalClock(clock))
    }
}

fileprivate class InternalClock : Clock {
    var impl : ClockImpl
    
    public init(_ impl: ClockImpl) {
        self.impl = impl
    }
    
    public var now: Date {
        return impl.now
    }
    
    public var nanoTime: UInt64 {
        return impl.nanoTime
    }
    
}
