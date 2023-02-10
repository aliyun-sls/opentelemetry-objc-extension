//
//  File.swift
//  
//
//  Created by gordon on 2023/2/10.
//

import Foundation
import URLSessionInstrumentation

public class URLSessionInstrumentationObjc: NSObject {
    public private(set) var urlSessionInstrumentation: URLSessionInstrumentation
    
    public init(_ urlSessionInstrumentation: URLSessionInstrumentation) {
        self.urlSessionInstrumentation = urlSessionInstrumentation
    }
    
    @objc
    @discardableResult public static func urlSessionInstrumentation(_ configuraiton: URLSessionInstrumentationConfigurationObjc) -> URLSessionInstrumentationObjc {
        return URLSessionInstrumentationObjc(URLSessionInstrumentation(configuration: configuraiton.urlSessionInstrumentationConfiguration))
    }
}
