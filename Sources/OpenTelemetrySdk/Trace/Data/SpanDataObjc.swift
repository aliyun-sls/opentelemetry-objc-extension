//
//  File.swift
//  
//
//  Created by gordon on 2023/2/9.
//

import Foundation
import OpenTelemetrySdk

public class SpanDataObjc : NSObject {
    var spanData: SpanData
    
    public init(_ spanData: SpanData) {
        self.spanData = spanData
    }
    
    
    @objc
    public class LinkObjc: NSObject {
        var link: SpanData.Link
        
        public init(_ link: SpanData.Link) {
            self.link = link
        }
    }
}
