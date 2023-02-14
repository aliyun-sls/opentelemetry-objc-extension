//
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


#import "AppDelegate.h"
@import OpenTelemetryApiObjc;
@import OpenTelemetrySdkObjc;
@import OpenTelemetryProtocolExporterObjc;
@import URLSessionInstrumentationObjc;
@import StdoutExporterObjc;

// TestURLSessionInstrumentation sample
#pragma mark - URLSessionInstrumentation
@interface TestURLSessionInstrumentation: NSObject<URLSessionInstrumentationConfigurationImpl>
+ (instancetype) instrumentation;
@end

@implementation TestURLSessionInstrumentation
+ (instancetype) instrumentation {
    return [[TestURLSessionInstrumentation alloc] init];
}
- (void)createdRequest:(NSURLRequest * _Nonnull)request span:(SpanObjc * _Nonnull)span {
    // called when request was created
    [span setAttribute:@"createdRequest" stringValue:@"request created"];
}
- (void)injectCustomHeaders:(NSURLRequest * _Nonnull)request span:(SpanObjc * _Nullable)span {
    // inject your custom header here
    [(NSMutableURLRequest *)request addValue:@"custom header" forHTTPHeaderField:@"injectCustomHeaders"];
}
- (NSString * _Nullable)nameSpan:(NSURLRequest * _Nonnull)request {
    // rename your span name
    if ([request.URL.host containsString:@"dns.alidns.com"]) {
        return @"请求解析DNS";
    }
    return nil;
}
- (void)receivedError:(NSError * _Nonnull)error dataOrFile:(NSObject * _Nullable)dataOrFile span:(SpanObjc * _Nonnull)span {
    // called when your request has error
}
- (void)receivedResponse:(NSURLResponse * _Nonnull)response dataOrFile:(NSObject * _Nullable)dataOrFile span:(SpanObjc * _Nonnull)span {
    // called when your request was successful
    NSLog(@"receivedResponse: %@", dataOrFile);
}
- (BOOL)shouldInjectTracingHeaders:(NSURLRequest * _Nonnull)request {
    // inject your tracing headers
    return YES;
}
- (BOOL)shouldInstrument:(NSURLRequest * _Nonnull)request {
    // 是否采集该request的数据
    return YES;
}
- (BOOL)shouldRecordPayload:(NSURLSession * _Nonnull)session {
    // whether record this payload
    return YES;
}
- (void)spanCustomization:(NSURLRequest * _Nonnull)request spanBuilder:(SpanBuilderObjc * _Nonnull)spanBuilder {
    // custom your span
    [spanBuilder setAttribute:@"spanCustomization" stringValue:@"customize span"];
}
@end

@interface AppDelegate ()
@property(nonatomic, strong) TracerObjc *tracer;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initOTel];
    return YES;
}

- (void) initOTel {
    // 初始化 exporter。exporter 的主要作用是导出 trace 数据到 sls logstore。
    // ${endpoint}、${port}、${project} 等变量的说明，参见下表变量说明。
    NSDictionary *headers = @{
        @"x-sls-otel-project": @"${project}",
        @"x-sls-otel-instance-id": @"${instanceId}",
        @"x-sls-otel-ak-id": @"${access-key-id}",
        @"x-sls-otel-ak-secret": @"${access-key-secret}"
    };
    OtlpConfigurationObjc *configuration = [OtlpConfigurationObjc configuration:OtlpConfigurationObjc.DefaultTimeoutInterval headers:headers];
    OtlpTraceExporterObjc *exporter = [OtlpTraceExporterObjc exporter:@"https://${endpoint}"
                                                                 port:@"${port}"
                                                        configuration:configuration
    ];
    
    // 初始化 tracer provider。tracer provider 暴露一些主要的API，用于对 Span 预处理，自定义Clock，
    // 自定义TraceId、SpanId生成规则，自定义采样器等。可以根据实际的需要进行配置
    // ${service}、${service.namespace} 等变量的说明，参见下表变量说明。
    NSArray *exporters = @[
        [StdoutExporterObjc stdoutExporter:true], // 开发调试时建议开启，可在console中打印出Span的具体的内容
        exporter
    ];
    SpanProcessorObjc *spanProcessor = [BatchSpanProcessorObjc processor: [MultiSpanExporterObjc multiSpanExporter:exporters]];
    
    TracerProviderBuilderObjc *providerBuilder = [TracerProviderBuilderObjc builder];
    NSDictionary *resources = @{
        ResourceAttributesObjc.serviceName: [AttributeValueObjc string:@"${service}"], // 当前要追踪trace的服务名称，建议取模块的名称，如：首页、会员中心
        ResourceAttributesObjc.serviceNamespace: [AttributeValueObjc string:@"${service.namespace}"], // 建议固定为 iOS/iPadOS/macOS/tvOS/watchOS
        ResourceAttributesObjc.serviceVersion: [AttributeValueObjc string:@"${version}"], // 建议和 App 版本号保持一致
        ResourceAttributesObjc.hostName: [AttributeValueObjc string:@"${host}"], // 建议固定为iOS
        ResourceAttributesObjc.deploymentEnvironment: [AttributeValueObjc string:@"${environment}"] // 开发环境，一般开发阶段建议设置为dev，线上环境设置为prod
    };
    providerBuilder = [providerBuilder withResource: [ResourceObjc resource:resources]];
    providerBuilder = [providerBuilder addSpanProcessor: spanProcessor];
    
    // 初始化 OpenTelemetrySdk。
    [OpenTelemetryObjc registerTracerProvider:[providerBuilder build]];
    
    // 配置其他的 Instrumentation 采集器。根据实际业务需要进行配置。如下配置是开启采集NSUrlSession网络库的请求信息。具体配置参考下文。
    [URLSessionInstrumentationObjc urlSessionInstrumentation:
         [URLSessionInstrumentationConfigurationObjc urlSessionInstrumentationConfiguration:[TestURLSessionInstrumentation instrumentation]]
    ];
    
    _tracer = [OpenTelemetryObjc.instance.tracerProvider get:@"ObjcSample" instrumentationVersion:@"0.0.1"];
    
    [self testSpan];
}

- (void) testSpan {
    SpanBuilderObjc *builder = [_tracer spanBuilder:@"testSpan"];
    SpanObjc *parent = [
        [
            [builder setSpanKind:SpanKindObjc.CLIENT]
            setActive:YES
        ] startSpan
    ];
    
    [[[_tracer spanBuilder:@"child in testSpan"] startSpan] end];
    [parent end];
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
