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
