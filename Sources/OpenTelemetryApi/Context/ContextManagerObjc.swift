//
//  ContextManagerObjc.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetryApi

//public class OpenTelemetryContextKeysObjc: NSObject {
//    @objc
//    public static let span = OpenTelemetryContextKeys.span.rawValue
//
//    @objc
//    public static let baggage = OpenTelemetryContextKeys.baggage.rawValue
//}

@objc
public enum OpenTelemetryContextKeysObjc: Int {
    case span
    case baggage
}

@objc
public protocol ContextManagerImpl {
    func getCurrentContextValue(_ forKey: OpenTelemetryContextKeysObjc) -> NSObject?
    func setCurrentContextValue(_ forKey: OpenTelemetryContextKeysObjc, value: NSObject)
    func removeContextValue(_ forKey: OpenTelemetryContextKeysObjc, value: NSObject)
}

public class ContextManagerObjc : NSObject {
    var contextManager: ContextManager
    
    public init(_ contextManager: ContextManager) {
        self.contextManager = contextManager
    }
    
    @objc
    public static func contextManager(_ impl: ContextManagerImpl) -> ContextManagerObjc {
        return ContextManagerObjc(InternalContextManager(impl))
    }
    
}

fileprivate class InternalContextManager: ContextManager {
    var impl: ContextManagerImpl

    public init(_ impl: ContextManagerImpl) {
        self.impl = impl
    }

    func getCurrentContextValue(forKey: OpenTelemetryContextKeys) -> AnyObject? {
        return impl.getCurrentContextValue(convertContextKeys(forKey))
    }

    func setCurrentContextValue(forKey: OpenTelemetryContextKeys, value: AnyObject) {
        impl.setCurrentContextValue(convertContextKeys(forKey), value: value as! NSObject)
    }

    func removeContextValue(forKey: OpenTelemetryContextKeys, value: AnyObject) {
        impl.removeContextValue(convertContextKeys(forKey), value: value as! NSObject)
    }

    func convertContextKeys(_ forKey: OpenTelemetryContextKeys) -> OpenTelemetryContextKeysObjc {
        switch (forKey) {
        case .span: return .span
        case .baggage: return .baggage
        }
    }
}


