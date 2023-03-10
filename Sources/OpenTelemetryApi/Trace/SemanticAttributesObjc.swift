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


public class SemanticAttributesObjc: NSObject {
    /**
    The full invoked ARN as provided on the `Context` passed to the function (`Lambda-Runtime-Invoked-Function-Arn` header on the `/runtime/invocation/next` applicable).

    ~~~
    // Examples
    attributes[.awsLambdaInvokedArn] = "arn:aws:lambda:us-east-1:123456:function:myfunction:myalias"
    ~~~

    - Note: This may be different from `faas.id` if an alias is involved.
    - Requires: Value type should be `String`
    */
    @objc public static var awsLambdaInvokedArn = "aws.lambda.invoked_arn"
    /**
    An identifier for the database management system (DBMS) product being used. See below for a list of well-known identifiers.
    - Requires: Value should be one of [`SemanticAttributes.DbSystemValues`](x-source-tag://otelDbSystemValues) (of type `String`)
    */
    @objc public static var dbSystem = "db.system"
    /**
    The connection string used to connect to the database. It is recommended to remove embedded credentials.

    ~~~
    // Examples
    attributes[.dbConnectionString] = "Server=(localdb)\v11.0;Integrated Security=true;"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var dbConnectionString = "db.connection_string"
    /**
    Username for accessing the database.

    ~~~
    // Examples
    attributes[.dbUser] = "readonly_user"
    attributes[.dbUser] = "reporting_user"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var dbUser = "db.user"
    /**
    The fully-qualified class name of the [Java Database Connectivity (JDBC)](https://docs.oracle.com/javase/8/docs/technotes/guides/jdbc/) driver used to connect.

    ~~~
    // Examples
    attributes[.dbJdbcDriverClassname] = "org.postgresql.Driver"
    attributes[.dbJdbcDriverClassname] = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var dbJdbcDriverClassname = "db.jdbc.driver_classname"
    /**
    If no [tech-specific attribute](#call-level-attributes-for-specific-technologies) is defined, this attribute is used to report the name of the database being accessed. For commands that switch the database, this should be set to the target database (even if the command fails).

    ~~~
    // Examples
    attributes[.dbName] = "customers"
    attributes[.dbName] = "main"
    ~~~

    - Note: In some SQL databases, the database name to be used is called "schema name".
    - Requires: Value type should be `String`
    */
    @objc public static var dbName = "db.name"
    /**
    The database statement being executed.

    ~~~
    // Examples
    attributes[.dbStatement] = "SELECT * FROM wuser_table"
    attributes[.dbStatement] = "SET mykey \"WuValue\""
    ~~~

    - Note: The value may be sanitized to exclude sensitive information.
    - Requires: Value type should be `String`
    */
    @objc public static var dbStatement = "db.statement"
    /**
    The name of the operation being executed, e.g. the [MongoDB command name](https://docs.mongodb.com/manual/reference/command/#database-operations) such as `findAndModify`, or the SQL keyword.

    ~~~
    // Examples
    attributes[.dbOperation] = "findAndModify"
    attributes[.dbOperation] = "HMSET"
    attributes[.dbOperation] = "SELECT"
    ~~~

    - Note: When setting this to an SQL keyword, it is not recommended to attempt any client-side parsing of `db.statement` just to get this property, but it should be set if the operation name is provided by the library being instrumented. If the SQL statement has an ambiguous operation, or performs more than one operation, this value may be omitted.
    - Requires: Value type should be `String`
    */
    @objc public static var dbOperation = "db.operation"
    /**
    Remote hostname or similar, see note below.

    ~~~
    // Examples
    attributes[.netPeerName] = "example.com"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var netPeerName = "net.peer.name"
    /**
    Remote address of the peer (dotted decimal for IPv4 or [RFC5952](https://tools.ietf.org/html/rfc5952) for IPv6).

    ~~~
    // Examples
    attributes[.netPeerIp] = "127.0.0.1"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var netPeerIp = "net.peer.ip"
    /**
    Remote port number.

    ~~~
    // Examplesattributes[.netPeerPort] = 80attributes[.netPeerPort] = 8080attributes[.netPeerPort] = 443
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var netPeerPort = "net.peer.port"
    /**
    Transport protocol used. See note below.
    - Requires: Value should be one of [`SemanticAttributes.NetTransportValues`](x-source-tag://otelNetTransportValues) (of type `String`)
    */
    @objc public static var netTransport = "net.transport"
    /**
    The Microsoft SQL Server [instance name](https://docs.microsoft.com/en-us/sql/connect/jdbc/building-the-connection-url?view=sql-server-ver15) connecting to. This name is used to determine the port of a named instance.

    ~~~
    // Examples
    attributes[.dbMssqlInstanceName] = "MSSQLSERVER"
    ~~~

    - Note: If setting a `db.mssql.instance_name`, `net.peer.port` is no longer required (but still recommended if non-standard).
    - Requires: Value type should be `String`
    */
    @objc public static var dbMssqlInstanceName = "db.mssql.instance_name"
    /**
    The name of the keyspace being accessed. To be used instead of the generic `db.name` attribute.

    ~~~
    // Examples
    attributes[.dbCassandraKeyspace] = "mykeyspace"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var dbCassandraKeyspace = "db.cassandra.keyspace"
    /**
    The fetch size used for paging, i.e. how many rows will be returned at once.

    ~~~
    // Examplesattributes[.dbCassandraPageSize] = 5000
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var dbCassandraPageSize = "db.cassandra.page_size"
    /**
    The consistency level of the query. Based on consistency values from [CQL](https://docs.datastax.com/en/cassandra-oss/3.0/cassandra/dml/dmlConfigConsistency.html).
    - Requires: Value should be one of [`SemanticAttributes.DbCassandraConsistencyLevelValues`](x-source-tag://otelDbCassandraConsistencyLevelValues) (of type `String`)
    */
    @objc public static var dbCassandraConsistencyLevel = "db.cassandra.consistency_level"
    /**
    The name of the primary table that the operation is acting upon, including the schema name (if applicable).

    ~~~
    // Examples
    attributes[.dbCassandraTable] = "mytable"
    ~~~

    - Note: This mirrors the db.sql.table attribute but references cassandra rather than sql. It is not recommended to attempt any client-side parsing of `db.statement` just to get this property, but it should be set if it is provided by the library being instrumented. If the operation is acting upon an anonymous table, or more than one table, this value MUST NOT be set.
    - Requires: Value type should be `String`
    */
    @objc public static var dbCassandraTable = "db.cassandra.table"
    /**
    Whether or not the query is idempotent.
    - Requires: Value type should be `Bool`
    */
    @objc public static var dbCassandraIdempotence = "db.cassandra.idempotence"
    /**
    The number of times a query was speculatively executed. Not set or `0` if the query was not executed speculatively.

    ~~~
    // Examplesattributes[.dbCassandraSpeculativeExecutionCount] = 0attributes[.dbCassandraSpeculativeExecutionCount] = 2
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var dbCassandraSpeculativeExecutionCount = "db.cassandra.speculative_execution_count"
    /**
    The ID of the coordinating node for a query.

    ~~~
    // Examples
    attributes[.dbCassandraCoordinatorId] = "be13faa2-8574-4d71-926d-27f16cf8a7af"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var dbCassandraCoordinatorId = "db.cassandra.coordinator.id"
    /**
    The data center of the coordinating node for a query.

    ~~~
    // Examples
    attributes[.dbCassandraCoordinatorDc] = "us-west-2"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var dbCassandraCoordinatorDc = "db.cassandra.coordinator.dc"
    /**
    The [HBase namespace](https://hbase.apache.org/book.html#_namespace) being accessed. To be used instead of the generic `db.name` attribute.

    ~~~
    // Examples
    attributes[.dbHbaseNamespace] = "default"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var dbHbaseNamespace = "db.hbase.namespace"
    /**
    The index of the database being accessed as used in the [`SELECT` command](https://redis.io/commands/select), provided as an integer. To be used instead of the generic `db.name` attribute.

    ~~~
    // Examplesattributes[.dbRedisDatabaseIndex] = 0attributes[.dbRedisDatabaseIndex] = 1attributes[.dbRedisDatabaseIndex] = 15
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var dbRedisDatabaseIndex = "db.redis.database_index"
    /**
    The collection being accessed within the database stated in `db.name`.

    ~~~
    // Examples
    attributes[.dbMongodbCollection] = "customers"
    attributes[.dbMongodbCollection] = "products"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var dbMongodbCollection = "db.mongodb.collection"
    /**
    The name of the primary table that the operation is acting upon, including the schema name (if applicable).

    ~~~
    // Examples
    attributes[.dbSqlTable] = "public.users"
    attributes[.dbSqlTable] = "customers"
    ~~~

    - Note: It is not recommended to attempt any client-side parsing of `db.statement` just to get this property, but it should be set if it is provided by the library being instrumented. If the operation is acting upon an anonymous table, or more than one table, this value MUST NOT be set.
    - Requires: Value type should be `String`
    */
    @objc public static var dbSqlTable = "db.sql.table"
    /**
    The type of the exception (its fully-qualified class name, if applicable). The dynamic type of the exception should be preferred over the static type in languages that support it.

    ~~~
    // Examples
    attributes[.exceptionType] = "java.net.ConnectException"
    attributes[.exceptionType] = "OSError"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var exceptionType = "exception.type"
    /**
    The exception message.

    ~~~
    // Examples
    attributes[.exceptionMessage] = "Division by zero"
    attributes[.exceptionMessage] = "Can't convert 'int' object to str implicitly"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var exceptionMessage = "exception.message"
    /**
    A stacktrace as a string in the natural representation for the language runtime. The representation is to be determined and documented by each language SIG.

    ~~~
    // Examples
    attributes[.exceptionStacktrace] = "Exception in thread \"main\" java.lang.RuntimeException: Test exception\n at com.example.GenerateTrace.methodB(GenerateTrace.java:13)\n at com.example.GenerateTrace.methodA(GenerateTrace.java:9)\n at com.example.GenerateTrace.main(GenerateTrace.java:5)"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var exceptionStacktrace = "exception.stacktrace"
    /**
    SHOULD be set to true if the exception event is recorded at a point where it is known that the exception is escaping the scope of the span.

    - Note: An exception is considered to have escaped (or left) the scope of a span,
      if that span is ended while the exception is still logically "in flight".
      This may be actually "in flight" in some languages (e.g. if the exception
      is passed to a Context manager's `__exit__` method in Python) but will
      usually be caught at the point of recording the exception in most languages.

      It is usually not possible to determine at the point where an exception is thrown
      whether it will escape the scope of a span.
      However, it is trivial to know that an exception
      will escape, if one checks for an active exception just before ending the span,
      as done in the [example above](#exception-end-example).

      It follows that an exception may still escape the scope of the span
      even if the `exception.escaped` attribute was not set or set to false,
      since the event might have been recorded at a time where it was not
      clear whether the exception will escape.
    - Requires: Value type should be `Bool`
    */
    @objc public static var exceptionEscaped = "exception.escaped"
    /**
    Type of the trigger on which the function is executed.
    - Requires: Value should be one of [`SemanticAttributes.FaasTriggerValues`](x-source-tag://otelFaasTriggerValues) (of type `String`)
    */
    @objc public static var faasTrigger = "faas.trigger"
    /**
    The execution ID of the current function execution.

    ~~~
    // Examples
    attributes[.faasExecution] = "af9d5aa4-a685-4c5f-a22b-444f80b3cc28"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var faasExecution = "faas.execution"
    /**
    The name of the source on which the triggering operation was performed. For example, in Cloud Storage or S3 corresponds to the bucket name, and in Cosmos DB to the database name.

    ~~~
    // Examples
    attributes[.faasDocumentCollection] = "myBucketName"
    attributes[.faasDocumentCollection] = "myDbName"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var faasDocumentCollection = "faas.document.collection"
    /**
    Describes the type of the operation that was performed on the data.
    - Requires: Value should be one of [`SemanticAttributes.FaasDocumentOperationValues`](x-source-tag://otelFaasDocumentOperationValues) (of type `String`)
    */
    @objc public static var faasDocumentOperation = "faas.document.operation"
    /**
    A string containing the time when the data was accessed in the [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format expressed in [UTC](https://www.w3.org/TR/NOTE-datetime).

    ~~~
    // Examples
    attributes[.faasDocumentTime] = "2020-01-23T13:47:06Z"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var faasDocumentTime = "faas.document.time"
    /**
    The document name/table subjected to the operation. For example, in Cloud Storage or S3 is the name of the file, and in Cosmos DB the table name.

    ~~~
    // Examples
    attributes[.faasDocumentName] = "myFile.txt"
    attributes[.faasDocumentName] = "myTableName"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var faasDocumentName = "faas.document.name"
    /**
    HTTP request method.

    ~~~
    // Examples
    attributes[.httpMethod] = "GET"
    attributes[.httpMethod] = "POST"
    attributes[.httpMethod] = "HEAD"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var httpMethod = "http.method"
    /**
    Full HTTP request URL in the form `scheme://host[:port]/path?query[#fragment]`. Usually the fragment is not transmitted over HTTP, but if it is known, it should be included nevertheless.

    ~~~
    // Examples
    attributes[.httpUrl] = "https://www.foo.bar/search?q=OpenTelemetry#SemConv"
    ~~~

    - Note: `http.url` MUST NOT contain credentials passed via URL in form of `https://username:password@www.example.com/`. In such @objc public static var the attribute's value should be `https://www.example.com/`.
    - Requires: Value type should be `String`
    */
    @objc public static var httpUrl = "http.url"
    /**
    The full request target as passed in a HTTP request line or equivalent.

    ~~~
    // Examples
    attributes[.httpTarget] = "/path/12314/?q=ddds#123"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var httpTarget = "http.target"
    /**
    The value of the [HTTP host header](https://tools.ietf.org/html/rfc7230#section-5.4). An empty Host header should also be reported, see note.

    ~~~
    // Examples
    attributes[.httpHost] = "www.example.org"
    ~~~

    - Note: When the header is present but empty the attribute SHOULD be set to the empty string. Note that this is a valid situation that is expected in certain cases, according the aforementioned [section of RFC 7230](https://tools.ietf.org/html/rfc7230#section-5.4). When the header is not set the attribute MUST NOT be set.
    - Requires: Value type should be `String`
    */
    @objc public static var httpHost = "http.host"
    /**
    The URI scheme identifying the used protocol.

    ~~~
    // Examples
    attributes[.httpScheme] = "http"
    attributes[.httpScheme] = "https"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var httpScheme = "http.scheme"
    /**
    [HTTP response status code](https://tools.ietf.org/html/rfc7231#section-6).

    ~~~
    // Examplesattributes[.httpStatusCode] = 200
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var httpStatusCode = "http.status_code"
    /**
    Kind of HTTP protocol used.

    - Note: If `net.transport` is not specified, it can be assumed to be `IP.TCP` except if `http.flavor` is `QUIC`, in which @objc public static var `IP.UDP` is assumed.
    - Requires: Value should be one of [`SemanticAttributes.HttpFlavorValues`](x-source-tag://otelHttpFlavorValues) (of type `String`)
    */
    @objc public static var httpFlavor = "http.flavor"
    /**
    Value of the [HTTP User-Agent](https://tools.ietf.org/html/rfc7231#section-5.5.3) header sent by the client.

    ~~~
    // Examples
    attributes[.httpUserAgent] = "CERN-LineMode/2.15 libwww/2.17b3"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var httpUserAgent = "http.user_agent"
    /**
    The size of the request payload body in bytes. This is the number of bytes transferred excluding headers and is often, but not always, present as the [Content-Length](https://tools.ietf.org/html/rfc7230#section-3.3.2) header. For requests using transport encoding, this should be the compressed size.

    ~~~
    // Examplesattributes[.httpRequestContentLength] = 3495
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var httpRequestContentLength = "http.request_content_length"
    /**
    The size of the uncompressed request payload body after transport decoding. Not set if transport encoding not used.

    ~~~
    // Examplesattributes[.httpRequestContentLengthUncompressed] = 5493
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var httpRequestContentLengthUncompressed = "http.request_content_length_uncompressed"
    /**
    The size of the response payload body in bytes. This is the number of bytes transferred excluding headers and is often, but not always, present as the [Content-Length](https://tools.ietf.org/html/rfc7230#section-3.3.2) header. For requests using transport encoding, this should be the compressed size.

    ~~~
    // Examplesattributes[.httpResponseContentLength] = 3495
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var httpResponseContentLength = "http.response_content_length"
    /**
    The size of the uncompressed response payload body after transport decoding. Not set if transport encoding not used.

    ~~~
    // Examplesattributes[.httpResponseContentLengthUncompressed] = 5493
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var httpResponseContentLengthUncompressed = "http.response_content_length_uncompressed"
    /**
    The primary server name of the matched virtual host. This should be obtained via configuration. If no such configuration can be obtained, this attribute MUST NOT be set ( `net.host.name` should be used instead).

    ~~~
    // Examples
    attributes[.httpServerName] = "example.com"
    ~~~

    - Note: `http.url` is usually not readily available on the server side but would have to be assembled in a cumbersome and sometimes lossy process from other information (see e.g. open-telemetry/opentelemetry-python/pull/148). It is thus preferred to supply the raw data that is available.
    - Requires: Value type should be `String`
    */
    @objc public static var httpServerName = "http.server_name"
    /**
    The matched route (path template).

    ~~~
    // Examples
    attributes[.httpRoute] = "/users/:userID?"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var httpRoute = "http.route"
    /**
    The IP address of the original client behind all proxies, if known (e.g. from [X-Forwarded-For](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Forwarded-For)).

    ~~~
    // Examples
    attributes[.httpClientIp] = "83.164.160.102"
    ~~~

    - Note: This is not necessarily the same as `net.peer.ip`, which would
      identify the network-level peer, which may be a proxy.

      This attribute should be set when a source of information different
      from the one used for `net.peer.ip`, is available even if that other
      source just confirms the same value as `net.peer.ip`.
      Rationale: For `net.peer.ip`, one typically does not know if it
      comes from a proxy, reverse proxy, or the actual client. Setting
      `http.client_ip` when it's the same as `net.peer.ip` means that
      one is at least somewhat confident that the address is not that of
      the closest proxy.
    - Requires: Value type should be `String`
    */
    @objc public static var httpClientIp = "http.client_ip"
    /**
    Like `net.peer.ip` but for the host IP. Useful in @objc public static var of a multi-IP host.

    ~~~
    // Examples
    attributes[.netHostIp] = "192.168.0.1"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var netHostIp = "net.host.ip"
    /**
    Like `net.peer.port` but for the host port.

    ~~~
    // Examplesattributes[.netHostPort] = 35555
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var netHostPort = "net.host.port"
    /**
    Local hostname or similar, see note below.

    ~~~
    // Examples
    attributes[.netHostName] = "localhost"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var netHostName = "net.host.name"
    /**
    The internet connection type currently being used by the host.

    ~~~
    // Examples
    attributes[.netHostConnectionType] = "wifi"
    ~~~
    - Requires: Value should be one of [`SemanticAttributes.NetHostConnectionTypeValues`](x-source-tag://otelNetHostConnectionTypeValues) (of type `String`)
    */
    @objc public static var netHostConnectionType = "net.host.connection.type"
    /**
    This describes more details regarding the connection.type. It may be the type of cell technology connection, but it could be used for describing details about a wifi connection.

    ~~~
    // Examples
    attributes[.netHostConnectionSubtype] = "LTE"
    ~~~
    - Requires: Value should be one of [`SemanticAttributes.NetHostConnectionSubtypeValues`](x-source-tag://otelNetHostConnectionSubtypeValues) (of type `String`)
    */
    @objc public static var netHostConnectionSubtype = "net.host.connection.subtype"
    /**
    The name of the mobile carrier.

    ~~~
    // Examples
    attributes[.netHostCarrierName] = "sprint"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var netHostCarrierName = "net.host.carrier.name"
    /**
    The mobile carrier country code.

    ~~~
    // Examples
    attributes[.netHostCarrierMcc] = "310"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var netHostCarrierMcc = "net.host.carrier.mcc"
    /**
    The mobile carrier network code.

    ~~~
    // Examples
    attributes[.netHostCarrierMnc] = "001"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var netHostCarrierMnc = "net.host.carrier.mnc"
    /**
    The ISO 3166-1 alpha-2 2-character country code associated with the mobile carrier network.

    ~~~
    // Examples
    attributes[.netHostCarrierIcc] = "DE"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var netHostCarrierIcc = "net.host.carrier.icc"
    /**
    A string identifying the messaging system.

    ~~~
    // Examples
    attributes[.messagingSystem] = "kafka"
    attributes[.messagingSystem] = "rabbitmq"
    attributes[.messagingSystem] = "activemq"
    attributes[.messagingSystem] = "AmazonSQS"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var messagingSystem = "messaging.system"
    /**
    The message destination name. This might be equal to the span name but is required nevertheless.

    ~~~
    // Examples
    attributes[.messagingDestination] = "MyQueue"
    attributes[.messagingDestination] = "MyTopic"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var messagingDestination = "messaging.destination"
    /**
    The kind of message destination.
    - Requires: Value should be one of [`SemanticAttributes.MessagingDestinationKindValues`](x-source-tag://otelMessagingDestinationKindValues) (of type `String`)
    */
    @objc public static var messagingDestinationKind = "messaging.destination_kind"
    /**
    A boolean that is true if the message destination is temporary.
    - Requires: Value type should be `Bool`
    */
    @objc public static var messagingTempDestination = "messaging.temp_destination"
    /**
    The name of the transport protocol.

    ~~~
    // Examples
    attributes[.messagingProtocol] = "AMQP"
    attributes[.messagingProtocol] = "MQTT"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var messagingProtocol = "messaging.protocol"
    /**
    The version of the transport protocol.

    ~~~
    // Examples
    attributes[.messagingProtocolVersion] = "0.9.1"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var messagingProtocolVersion = "messaging.protocol_version"
    /**
    Connection string.

    ~~~
    // Examples
    attributes[.messagingUrl] = "tibjmsnaming://localhost:7222"
    attributes[.messagingUrl] = "https://queue.amazonaws.com/80398EXAMPLE/MyQueue"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var messagingUrl = "messaging.url"
    /**
    A value used by the messaging system as an identifier for the message, represented as a string.

    ~~~
    // Examples
    attributes[.messagingMessageId] = "452a7c7c7c7048c2f887f61572b18fc2"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var messagingMessageId = "messaging.message_id"
    /**
    The [conversation ID](#conversations) identifying the conversation to which the message belongs, represented as a string. Sometimes called "Correlation ID".

    ~~~
    // Examples
    attributes[.messagingConversationId] = "MyConversationId"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var messagingConversationId = "messaging.conversation_id"
    /**
    The (uncompressed) size of the message payload in bytes. Also use this attribute if it is unknown whether the compressed or uncompressed payload size is reported.

    ~~~
    // Examplesattributes[.messagingMessagePayloadSizeBytes] = 2738
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var messagingMessagePayloadSizeBytes = "messaging.message_payload_size_bytes"
    /**
    The compressed size of the message payload in bytes.

    ~~~
    // Examplesattributes[.messagingMessagePayloadCompressedSizeBytes] = 2048
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var messagingMessagePayloadCompressedSizeBytes = "messaging.message_payload_compressed_size_bytes"
    /**
    A string containing the function invocation time in the [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format expressed in [UTC](https://www.w3.org/TR/NOTE-datetime).

    ~~~
    // Examples
    attributes[.faasTime] = "2020-01-23T13:47:06Z"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var faasTime = "faas.time"
    /**
    A string containing the schedule period as [Cron Expression](https://docs.oracle.com/cd/E12058_01/doc/doc.1014/e12030/cron_expressions.htm).

    ~~~
    // Examples
    attributes[.faasCron] = "0/5 * * * ? *"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var faasCron = "faas.cron"
    /**
    A boolean that is true if the serverless function is executed for the first time (aka cold-start).
    - Requires: Value type should be `Bool`
    */
    @objc public static var faasColdstart = "faas.coldstart"
    /**
    The name of the invoked function.

    ~~~
    // Examples
    attributes[.faasInvokedName] = "my-function"
    ~~~

    - Note: SHOULD be equal to the `faas.name` resource attribute of the invoked function.
    - Requires: Value type should be `String`
    */
    @objc public static var faasInvokedName = "faas.invoked_name"
    /**
    The cloud provider of the invoked function.

    - Note: SHOULD be equal to the `cloud.provider` resource attribute of the invoked function.
    - Requires: Value should be one of [`SemanticAttributes.FaasInvokedProviderValues`](x-source-tag://otelFaasInvokedProviderValues) (of type `String`)
    */
    @objc public static var faasInvokedProvider = "faas.invoked_provider"
    /**
    The cloud region of the invoked function.

    ~~~
    // Examples
    attributes[.faasInvokedRegion] = "eu-central-1"
    ~~~

    - Note: SHOULD be equal to the `cloud.region` resource attribute of the invoked function.
    - Requires: Value type should be `String`
    */
    @objc public static var faasInvokedRegion = "faas.invoked_region"
    /**
    The [`service.name`](../../resource/semantic_conventions/README.md#service) of the remote service. SHOULD be equal to the actual `service.name` resource attribute of the remote service if any.

    ~~~
    // Examples
    attributes[.peerService] = "AuthTokenCache"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var peerService = "peer.service"
    /**
    Username or client_id extracted from the access token or [Authorization](https://tools.ietf.org/html/rfc7235#section-4.2) header in the inbound request from outside the system.

    ~~~
    // Examples
    attributes[.enduserId] = "username"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var enduserId = "enduser.id"
    /**
    Actual/assumed role the client is making the request under extracted from token or application security context.

    ~~~
    // Examples
    attributes[.enduserRole] = "admin"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var enduserRole = "enduser.role"
    /**
    Scopes or granted authorities the client currently possesses extracted from token or application security context. The value would come from the scope associated with an [OAuth 2.0 Access Token](https://tools.ietf.org/html/rfc6749#section-3.3) or an attribute value in a [SAML 2.0 Assertion](http://docs.oasis-open.org/security/saml/Post2.0/sstc-saml-tech-overview-2.0.html).

    ~~~
    // Examples
    attributes[.enduserScope] = "read:message, write:files"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var enduserScope = "enduser.scope"
    /**
    Current "managed" thread ID (as opposed to OS thread ID).

    ~~~
    // Examplesattributes[.threadId] = 42
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var threadId = "thread.id"
    /**
    Current thread name.

    ~~~
    // Examples
    attributes[.threadName] = "main"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var threadName = "thread.name"
    /**
    The method or function name, or equivalent (usually rightmost part of the code unit's name).

    ~~~
    // Examples
    attributes[.codeFunction] = "serveRequest"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var codeFunction = "code.function"
    /**
    The "namespace" within which `code.function` is defined. Usually the qualified class or module name, such that `code.namespace` + some separator + `code.function` form a unique identifier for the code unit.

    ~~~
    // Examples
    attributes[.codeNamespace] = "com.example.MyHttpService"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var codeNamespace = "code.namespace"
    /**
    The source code file name that identifies the code unit as uniquely as possible (preferably an absolute file path).

    ~~~
    // Examples
    attributes[.codeFilepath] = "/usr/local/MyApplication/content_root/app/index.php"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var codeFilepath = "code.filepath"
    /**
    The line number in `code.filepath` best representing the operation. It SHOULD point within the code unit named in `code.function`.

    ~~~
    // Examplesattributes[.codeLineno] = 42
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var codeLineno = "code.lineno"
    /**
    The value `aws-api`.

    ~~~
    // Examples
    attributes[.rpcSystem] = "aws-api"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var rpcSystem = "rpc.system"
    /**
    The name of the service to which a request is made, as returned by the AWS SDK.

    ~~~
    // Examples
    attributes[.rpcService] = "DynamoDB"
    attributes[.rpcService] = "S3"
    ~~~

    - Note: This is the logical name of the service from the RPC interface perspective, which can be different from the name of any implementing class. The `code.namespace` attribute may be used to store the latter (despite the attribute name, it may include a class name; e.g., class with method actually executing the call on the server side, RPC client stub class on the client side).
    - Requires: Value type should be `String`
    */
    @objc public static var rpcService = "rpc.service"
    /**
    The name of the operation corresponding to the request, as returned by the AWS SDK.

    ~~~
    // Examples
    attributes[.rpcMethod] = "GetItem"
    attributes[.rpcMethod] = "PutItem"
    ~~~

    - Note: This is the logical name of the method from the RPC interface perspective, which can be different from the name of any implementing method/function. The `code.function` attribute may be used to store the latter (e.g., method actually executing the call on the server side, RPC client stub method on the client side).
    - Requires: Value type should be `String`
    */
    @objc public static var rpcMethod = "rpc.method"
    /**
    The keys in the `RequestItems` object field.

    ~~~
    // Examplesattributes[.awsDynamodbTableNames] = Usersattributes[.awsDynamodbTableNames] = Cats
    ~~~
    - Requires: Value type should be `[String]`
    */
    @objc public static var awsDynamodbTableNames = "aws.dynamodb.table_names"
    /**
    The JSON-serialized value of each item in the `ConsumedCapacity` response field.

    ~~~
    // Examplesattributes[.awsDynamodbConsumedCapacity] = { "CapacityUnits": number, "GlobalSecondaryIndexes": { "string" : { "CapacityUnits": number, "ReadCapacityUnits": number, "WriteCapacityUnits": number } }, "LocalSecondaryIndexes": { "string" : { "CapacityUnits": number, "ReadCapacityUnits": number, "WriteCapacityUnits": number } }, "ReadCapacityUnits": number, "Table": { "CapacityUnits": number, "ReadCapacityUnits": number, "WriteCapacityUnits": number }, "TableName": "string", "WriteCapacityUnits": number }
    ~~~
    - Requires: Value type should be `[String]`
    */
    @objc public static var awsDynamodbConsumedCapacity = "aws.dynamodb.consumed_capacity"
    /**
    The JSON-serialized value of the `ItemCollectionMetrics` response field.

    ~~~
    // Examples
    attributes[.awsDynamodbItemCollectionMetrics] = "{ \"string\" : [ { \"ItemCollectionKey\": { \"string\" : { \"B\": blob, \"BOOL\": boolean, \"BS\": [ blob ], \"L\": [ \"AttributeValue\" ], \"M\": { \"string\" : \"AttributeValue\" }, \"N\": \"string\", \"NS\": [ \"string\" ], \"NULL\": boolean, \"S\": \"string\", \"SS\": [ \"string\" ] } }, \"SizeEstimateRangeGB\": [ number ] } ] }"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var awsDynamodbItemCollectionMetrics = "aws.dynamodb.item_collection_metrics"
    /**
    The value of the `ProvisionedThroughput.ReadCapacityUnits` request parameter.

    ~~~
    // Examplesattributes[.awsDynamodbProvisionedReadCapacity] = 1.0attributes[.awsDynamodbProvisionedReadCapacity] = 2.0
    ~~~
    - Requires: Value type should be `double`
    */
    @objc public static var awsDynamodbProvisionedReadCapacity = "aws.dynamodb.provisioned_read_capacity"
    /**
    The value of the `ProvisionedThroughput.WriteCapacityUnits` request parameter.

    ~~~
    // Examplesattributes[.awsDynamodbProvisionedWriteCapacity] = 1.0attributes[.awsDynamodbProvisionedWriteCapacity] = 2.0
    ~~~
    - Requires: Value type should be `double`
    */
    @objc public static var awsDynamodbProvisionedWriteCapacity = "aws.dynamodb.provisioned_write_capacity"
    /**
    The value of the `ConsistentRead` request parameter.
    - Requires: Value type should be `Bool`
    */
    @objc public static var awsDynamodbConsistentRead = "aws.dynamodb.consistent_read"
    /**
    The value of the `ProjectionExpression` request parameter.

    ~~~
    // Examples
    attributes[.awsDynamodbProjection] = "Title"
    attributes[.awsDynamodbProjection] = "Title, Price, Color"
    attributes[.awsDynamodbProjection] = "Title, Description, RelatedItems, ProductReviews"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var awsDynamodbProjection = "aws.dynamodb.projection"
    /**
    The value of the `Limit` request parameter.

    ~~~
    // Examplesattributes[.awsDynamodbLimit] = 10
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var awsDynamodbLimit = "aws.dynamodb.limit"
    /**
    The value of the `AttributesToGet` request parameter.

    ~~~
    // Examplesattributes[.awsDynamodbAttributesToGet] = livesattributes[.awsDynamodbAttributesToGet] = id
    ~~~
    - Requires: Value type should be `[String]`
    */
    @objc public static var awsDynamodbAttributesToGet = "aws.dynamodb.attributes_to_get"
    /**
    The value of the `IndexName` request parameter.

    ~~~
    // Examples
    attributes[.awsDynamodbIndexName] = "name_to_group"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var awsDynamodbIndexName = "aws.dynamodb.index_name"
    /**
    The value of the `Select` request parameter.

    ~~~
    // Examples
    attributes[.awsDynamodbSelect] = "ALL_ATTRIBUTES"
    attributes[.awsDynamodbSelect] = "COUNT"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var awsDynamodbSelect = "aws.dynamodb.select"
    /**
    The JSON-serialized value of each item of the `GlobalSecondaryIndexes` request field.

    ~~~
    // Examplesattributes[.awsDynamodbGlobalSecondaryIndexes] = { "IndexName": "string", "KeySchema": [ { "AttributeName": "string", "KeyType": "string" } ], "Projection": { "NonKeyAttributes": [ "string" ], "ProjectionType": "string" }, "ProvisionedThroughput": { "ReadCapacityUnits": number, "WriteCapacityUnits": number } }
    ~~~
    - Requires: Value type should be `[String]`
    */
    @objc public static var awsDynamodbGlobalSecondaryIndexes = "aws.dynamodb.global_secondary_indexes"
    /**
    The JSON-serialized value of each item of the `LocalSecondaryIndexes` request field.

    ~~~
    // Examplesattributes[.awsDynamodbLocalSecondaryIndexes] = { "IndexArn": "string", "IndexName": "string", "IndexSizeBytes": number, "ItemCount": number, "KeySchema": [ { "AttributeName": "string", "KeyType": "string" } ], "Projection": { "NonKeyAttributes": [ "string" ], "ProjectionType": "string" } }
    ~~~
    - Requires: Value type should be `[String]`
    */
    @objc public static var awsDynamodbLocalSecondaryIndexes = "aws.dynamodb.local_secondary_indexes"
    /**
    The value of the `ExclusiveStartTableName` request parameter.

    ~~~
    // Examples
    attributes[.awsDynamodbExclusiveStartTable] = "Users"
    attributes[.awsDynamodbExclusiveStartTable] = "CatsTable"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var awsDynamodbExclusiveStartTable = "aws.dynamodb.exclusive_start_table"
    /**
    The the number of items in the `TableNames` response parameter.

    ~~~
    // Examplesattributes[.awsDynamodbTableCount] = 20
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var awsDynamodbTableCount = "aws.dynamodb.table_count"
    /**
    The value of the `ScanIndexForward` request parameter.
    - Requires: Value type should be `Bool`
    */
    @objc public static var awsDynamodbScanForward = "aws.dynamodb.scan_forward"
    /**
    The value of the `Segment` request parameter.

    ~~~
    // Examplesattributes[.awsDynamodbSegment] = 10
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var awsDynamodbSegment = "aws.dynamodb.segment"
    /**
    The value of the `TotalSegments` request parameter.

    ~~~
    // Examplesattributes[.awsDynamodbTotalSegments] = 100
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var awsDynamodbTotalSegments = "aws.dynamodb.total_segments"
    /**
    The value of the `Count` response parameter.

    ~~~
    // Examplesattributes[.awsDynamodbCount] = 10
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var awsDynamodbCount = "aws.dynamodb.count"
    /**
    The value of the `ScannedCount` response parameter.

    ~~~
    // Examplesattributes[.awsDynamodbScannedCount] = 50
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var awsDynamodbScannedCount = "aws.dynamodb.scanned_count"
    /**
    The JSON-serialized value of each item in the `AttributeDefinitions` request field.

    ~~~
    // Examplesattributes[.awsDynamodbAttributeDefinitions] = { "AttributeName": "string", "AttributeType": "string" }
    ~~~
    - Requires: Value type should be `[String]`
    */
    @objc public static var awsDynamodbAttributeDefinitions = "aws.dynamodb.attribute_definitions"
    /**
    The JSON-serialized value of each item in the the `GlobalSecondaryIndexUpdates` request field.

    ~~~
    // Examplesattributes[.awsDynamodbGlobalSecondaryIndexUpdates] = { "Create": { "IndexName": "string", "KeySchema": [ { "AttributeName": "string", "KeyType": "string" } ], "Projection": { "NonKeyAttributes": [ "string" ], "ProjectionType": "string" }, "ProvisionedThroughput": { "ReadCapacityUnits": number, "WriteCapacityUnits": number } }
    ~~~
    - Requires: Value type should be `[String]`
    */
    @objc public static var awsDynamodbGlobalSecondaryIndexUpdates = "aws.dynamodb.global_secondary_index_updates"
    /**
    A string identifying the kind of message consumption as defined in the [Operation names](#operation-names) section above. If the operation is "send", this attribute MUST NOT be set, since the operation can be inferred from the span kind in that @objc public static var.
    - Requires: Value should be one of [`SemanticAttributes.MessagingOperationValues`](x-source-tag://otelMessagingOperationValues) (of type `String`)
    */
    @objc public static var messagingOperation = "messaging.operation"
    /**
    The identifier for the consumer receiving a message. For Kafka, set it to `{messaging.kafka.consumer_group} - {messaging.kafka.client_id}`, if both are present, or only `messaging.kafka.consumer_group`. For brokers, such as RabbitMQ and Artemis, set it to the `client_id` of the client consuming the message.

    ~~~
    // Examples
    attributes[.messagingConsumerId] = "mygroup - client-6"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var messagingConsumerId = "messaging.consumer_id"
    /**
    RabbitMQ message routing key.

    ~~~
    // Examples
    attributes[.messagingRabbitmqRoutingKey] = "myKey"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var messagingRabbitmqRoutingKey = "messaging.rabbitmq.routing_key"
    /**
    Message keys in Kafka are used for grouping alike messages to ensure they're processed on the same partition. They differ from `messaging.message_id` in that they're not unique. If the key is `null`, the attribute MUST NOT be set.

    ~~~
    // Examples
    attributes[.messagingKafkaMessageKey] = "myKey"
    ~~~

    - Note: If the key type is not string, it's string representation has to be supplied for the attribute. If the key has no unambiguous, canonical string form, don't include its value.
    - Requires: Value type should be `String`
    */
    @objc public static var messagingKafkaMessageKey = "messaging.kafka.message_key"
    /**
    Name of the Kafka Consumer Group that is handling the message. Only applies to consumers, not producers.

    ~~~
    // Examples
    attributes[.messagingKafkaConsumerGroup] = "my-group"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var messagingKafkaConsumerGroup = "messaging.kafka.consumer_group"
    /**
    Client Id for the Consumer or Producer that is handling the message.

    ~~~
    // Examples
    attributes[.messagingKafkaClientId] = "client-5"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var messagingKafkaClientId = "messaging.kafka.client_id"
    /**
    Partition the message is sent to.

    ~~~
    // Examplesattributes[.messagingKafkaPartition] = 2
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var messagingKafkaPartition = "messaging.kafka.partition"
    /**
    A boolean that is true if the message is a tombstone.
    - Requires: Value type should be `Bool`
    */
    @objc public static var messagingKafkaTombstone = "messaging.kafka.tombstone"
    /**
    The [numeric status code](https://github.com/grpc/grpc/blob/v1.33.2/doc/statuscodes.md) of the gRPC request.
    - Requires: Value should be one of [`SemanticAttributes.RpcGrpcStatusCodeValues`](x-source-tag://otelRpcGrpcStatusCodeValues) (of type `Int`)
    */
    @objc public static var rpcGrpcStatusCode = "rpc.grpc.status_code"
    /**
    Protocol version as in `jsonrpc` property of request/response. Since JSON-RPC 1.0 does not specify this, the value can be omitted.

    ~~~
    // Examples
    attributes[.rpcJsonrpcVersion] = "2.0"
    attributes[.rpcJsonrpcVersion] = "1.0"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var rpcJsonrpcVersion = "rpc.jsonrpc.version"
    /**
    `id` property of request or response. Since protocol allows id to be int, string, `null` or missing (for notifications), value is expected to be cast to string for simplicity. Use empty string in @objc public static var of `null` value. Omit entirely if this is a notification.

    ~~~
    // Examples
    attributes[.rpcJsonrpcRequestId] = "10"
    attributes[.rpcJsonrpcRequestId] = "request-7"
    attributes[.rpcJsonrpcRequestId] = ""
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var rpcJsonrpcRequestId = "rpc.jsonrpc.request_id"
    /**
    `error.code` property of response if it is an error response.

    ~~~
    // Examplesattributes[.rpcJsonrpcErrorCode] = -32700attributes[.rpcJsonrpcErrorCode] = 100
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var rpcJsonrpcErrorCode = "rpc.jsonrpc.error_code"
    /**
    `error.message` property of response if it is an error response.

    ~~~
    // Examples
    attributes[.rpcJsonrpcErrorMessage] = "Parse error"
    attributes[.rpcJsonrpcErrorMessage] = "User already exists"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var rpcJsonrpcErrorMessage = "rpc.jsonrpc.error_message"
    /**
    Whether this is a received or sent message.
    - Requires: Value should be one of [`SemanticAttributes.MessageTypeValues`](x-source-tag://otelMessageTypeValues) (of type `String`)
    */
    @objc public static var messageType = "message.type"
    /**
    MUST be calculated as two different counters starting from `1` one for sent messages and one for received message.

    - Note: This way we guarantee that the values will be consistent between different implementations.
    - Requires: Value type should be `Int`
    */
    @objc public static var messageId = "message.id"
    /**
    Compressed size of the message in bytes.
    - Requires: Value type should be `Int`
    */
    @objc public static var messageCompressedSize = "message.compressed_size"
    /**
    Uncompressed size of the message in bytes.
    - Requires: Value type should be `Int`
    */
    @objc public static var messageUncompressedSize = "message.uncompressed_size"

    // MARK: - Manual Definitions
    // Some definitions have not yet been added to the YAML which generates this script.
    // As such as we have some manually defined cases.

    /**
    An exception event **MUST** be called "exception" as per the [specification](https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/trace/semantic_conventions/exceptions.md).
    */
    @objc public static var exception = "exception";
    
    /**
    An identifier for the database management system (DBMS) product being used. See below for a list of well-known identifiers.
    */
    /// - Tag: otelDbSystemValues
    @objc public class DbSystemValuesObjc: NSObject {
        /**
        Some other SQL database. Fallback only. See notes.
        */
        public static let otherSql = DbSystemValuesObjc("other_sql")
        /**
        Microsoft SQL Server.
        */
        public static let mssql = DbSystemValuesObjc("mssql")
        /**
        MySQL.
        */
        public static let mysql = DbSystemValuesObjc("mysql")
        /**
        Oracle Database.
        */
        public static let oracle = DbSystemValuesObjc("oracle")
        /**
        IBM Db2.
        */
        public static let db2 = DbSystemValuesObjc("db2")
        /**
        PostgreSQL.
        */
        public static let postgresql = DbSystemValuesObjc("postgresql")
        /**
        Amazon Redshift.
        */
        public static let redshift = DbSystemValuesObjc("redshift")
        /**
        Apache Hive.
        */
        public static let hive = DbSystemValuesObjc("hive")
        /**
        Cloudscape.
        */
        public static let cloudscape = DbSystemValuesObjc("cloudscape")
        /**
        HyperSQL DataBase.
        */
        public static let hsqldb = DbSystemValuesObjc("hsqldb")
        /**
        Progress Database.
        */
        public static let progress = DbSystemValuesObjc("progress")
        /**
        SAP MaxDB.
        */
        public static let maxdb = DbSystemValuesObjc("maxdb")
        /**
        SAP HANA.
        */
        public static let hanadb = DbSystemValuesObjc("hanadb")
        /**
        Ingres.
        */
        public static let ingres = DbSystemValuesObjc("ingres")
        /**
        FirstSQL.
        */
        public static let firstsql = DbSystemValuesObjc("firstsql")
        /**
        EnterpriseDB.
        */
        public static let edb = DbSystemValuesObjc("edb")
        /**
        InterSystems Cach??.
        */
        public static let cache = DbSystemValuesObjc("cache")
        /**
        Adabas (Adaptable Database System).
        */
        public static let adabas = DbSystemValuesObjc("adabas")
        /**
        Firebird.
        */
        public static let firebird = DbSystemValuesObjc("firebird")
        /**
        Apache Derby.
        */
        public static let derby = DbSystemValuesObjc("derby")
        /**
        FileMaker.
        */
        public static let filemaker = DbSystemValuesObjc("filemaker")
        /**
        Informix.
        */
        public static let informix = DbSystemValuesObjc("informix")
        /**
        InstantDB.
        */
        public static let instantdb = DbSystemValuesObjc("instantdb")
        /**
        InterBase.
        */
        public static let interbase = DbSystemValuesObjc("interbase")
        /**
        MariaDB.
        */
        public static let mariadb = DbSystemValuesObjc("mariadb")
        /**
        Netezza.
        */
        public static let netezza = DbSystemValuesObjc("netezza")
        /**
        Pervasive PSQL.
        */
        public static let pervasive = DbSystemValuesObjc("pervasive")
        /**
        PointBase.
        */
        public static let pointbase = DbSystemValuesObjc("pointbase")
        /**
        SQLite.
        */
        public static let sqlite = DbSystemValuesObjc("sqlite")
        /**
        Sybase.
        */
        public static let sybase = DbSystemValuesObjc("sybase")
        /**
        Teradata.
        */
        public static let teradata = DbSystemValuesObjc("teradata")
        /**
        Vertica.
        */
        public static let vertica = DbSystemValuesObjc("vertica")
        /**
        H2.
        */
        public static let h2 = DbSystemValuesObjc("h2")
        /**
        ColdFusion IMQ.
        */
        public static let coldfusion = DbSystemValuesObjc("coldfusion")
        /**
        Apache Cassandra.
        */
        public static let cassandra = DbSystemValuesObjc("cassandra")
        /**
        Apache HBase.
        */
        public static let hbase = DbSystemValuesObjc("hbase")
        /**
        MongoDB.
        */
        public static let mongodb = DbSystemValuesObjc("mongodb")
        /**
        Redis.
        */
        public static let redis = DbSystemValuesObjc("redis")
        /**
        Couchbase.
        */
        public static let couchbase = DbSystemValuesObjc("couchbase")
        /**
        CouchDB.
        */
        public static let couchdb = DbSystemValuesObjc("couchdb")
        /**
        Microsoft Azure Cosmos DB.
        */
        public static let cosmosdb = DbSystemValuesObjc("cosmosdb")
        /**
        Amazon DynamoDB.
        */
        public static let dynamodb = DbSystemValuesObjc("dynamodb")
        /**
        Neo4j.
        */
        public static let neo4j = DbSystemValuesObjc("neo4j")
        /**
        Apache Geode.
        */
        public static let geode = DbSystemValuesObjc("geode")
        /**
        Elasticsearch.
        */
        public static let elasticsearch = DbSystemValuesObjc("elasticsearch")
        /**
        Memcached.
        */
        public static let memcached = DbSystemValuesObjc("memcached")
        /**
        CockroachDB.
        */
        public static let cockroachdb = DbSystemValuesObjc("cockroachdb")

        internal let value: String

        public init(_ customValue: String) {
            self.value = customValue
        }

        public override var description: String {
            return value
        }
    }
    
    /**
    Transport protocol used. See note below.
    */
    /// - Tag: otelNetTransportValues
    @objc public class NetTransportValuesObjc : NSObject {
        /**
        ip_tcp.
        */
        @objc public static var ip_tcp = "ip_tcp"
        /**
        ip_udp.
        */
        @objc public static var ip_udp = "ip_udp"
        /**
        Another IP-based protocol.
        */
        @objc public static var ip = "ip"
        /**
        Unix Domain socket. See below.
        */
        @objc public static var unix = "unix"
        /**
        Named or anonymous pipe. See note below.
        */
        @objc public static var pipe = "pipe"
        /**
        In-process communication.
        */
        @objc public static var inproc = "inproc"
        /**
        Something else (non IP-based).
        */
        @objc public static var other = "other"
    }
    
    /**
    The consistency level of the query. Based on consistency values from [CQL](https://docs.datastax.com/en/cassandra-oss/3.0/cassandra/dml/dmlConfigConsistency.html).
    */
    /// - Tag: otelDbCassandraConsistencyLevelValues
    @objc public class DbCassandraConsistencyLevelValuesObjc : NSObject {
        /**
        all.
        */
        @objc public static var all = "all"
        /**
        each_quorum.
        */
        @objc public static var each_quorum = "each_quorum"
        /**
        quorum.
        */
        @objc public static var quorum = "quorum"
        /**
        local_quorum.
        */
        @objc public static var local_quorum = "local_quorum"
        /**
        one.
        */
        @objc public static var one = "one"
        /**
        two.
        */
        @objc public static var two = "two"
        /**
        three.
        */
        @objc public static var three = "three"
        /**
        local_one.
        */
        @objc public static var local_one = "local_one"
        /**
        any.
        */
        @objc public static var any = "any"
        /**
        serial.
        */
        @objc public static var serial = "serial"
        /**
        local_serial.
        */
        @objc public static var local_serial = "local_serial"
    }
    
    /**
    Type of the trigger on which the function is executed.
    */
    /// - Tag: otelFaasTriggerValues
    @objc public class FaasTriggerValuesObjc : NSObject {
        /**
        A response to some data source operation such as a database or filesystem read/write.
        */
        @objc public static var datasource = "datasource"
        /**
        To provide an answer to an inbound HTTP request.
        */
        @objc public static var http = "http"
        /**
        A function is set to be executed when messages are sent to a messaging system.
        */
        @objc public static var pubsub = "pubsub"
        /**
        A function is scheduled to be executed regularly.
        */
        @objc public static var timer = "timer"
        /**
        If none of the others apply.
        */
        @objc public static var other = "other"
    }
    
    /**
    Describes the type of the operation that was performed on the data.
    */
    /// - Tag: otelFaasDocumentOperationValues
    @objc public class FaasDocumentOperationValuesObjc: NSObject {
        /**
        When a new object is created.
        */
        public static let insert = FaasDocumentOperationValuesObjc("insert")
        /**
        When an object is modified.
        */
        public static let edit = FaasDocumentOperationValuesObjc("edit")
        /**
        When an object is deleted.
        */
        public static let delete = FaasDocumentOperationValuesObjc("delete")

        internal let value: String

        public init(_ customValue: String) {
            self.value = customValue
        }

        public override var description: String {
            return value
        }
    }
    
    /**
    Kind of HTTP protocol used.
    */
    /// - Tag: otelHttpFlavorValues
    @objc public class HttpFlavorValuesObjc: NSObject {
        /**
        HTTP 1.0.
        */
        public static let http10 = HttpFlavorValuesObjc("1.0")
        /**
        HTTP 1.1.
        */
        public static let http11 = HttpFlavorValuesObjc("1.1")
        /**
        HTTP 2.
        */
        public static let http20 = HttpFlavorValuesObjc("2.0")
        /**
        SPDY protocol.
        */
        public static let spdy = HttpFlavorValuesObjc("SPDY")
        /**
        QUIC protocol.
        */
        public static let quic = HttpFlavorValuesObjc("QUIC")

        internal let value: String

        public init(_ customValue: String) {
            self.value = customValue
        }

        public override var description: String {
            return value
        }
    }
    
    /**
    The internet connection type currently being used by the host.
    */
    /// - Tag: otelNetHostConnectionTypeValues
    @objc public class NetHostConnectionTypeValuesObjc: NSObject {
        /**
        wifi.
        */
        public static let wifi = NetHostConnectionTypeValuesObjc("wifi")
        /**
        wired.
        */
        public static let wired = NetHostConnectionTypeValuesObjc("wired")
        /**
        cell.
        */
        public static let cell = NetHostConnectionTypeValuesObjc("cell")
        /**
        unavailable.
        */
        public static let unavailable = NetHostConnectionTypeValuesObjc("unavailable")
        /**
        unknown.
        */
        public static let unknown = NetHostConnectionTypeValuesObjc("unknown")

        internal let value: String

        public init(_ customValue: String) {
            self.value = customValue
        }

        public override var description: String {
            return value
        }
    }
    
    /**
    This describes more details regarding the connection.type. It may be the type of cell technology connection, but it could be used for describing details about a wifi connection.
    */
    /// - Tag: otelNetHostConnectionSubtypeValues
    @objc public class NetHostConnectionSubtypeValuesObjc: NSObject {
        /**
        GPRS.
        */
        public static let gprs = NetHostConnectionSubtypeValuesObjc("gprs")
        /**
        EDGE.
        */
        public static let edge = NetHostConnectionSubtypeValuesObjc("edge")
        /**
        UMTS.
        */
        public static let umts = NetHostConnectionSubtypeValuesObjc("umts")
        /**
        CDMA.
        */
        public static let cdma = NetHostConnectionSubtypeValuesObjc("cdma")
        /**
        EVDO Rel. 0.
        */
        public static let evdo0 = NetHostConnectionSubtypeValuesObjc("evdo_0")
        /**
        EVDO Rev. A.
        */
        public static let evdoA = NetHostConnectionSubtypeValuesObjc("evdo_a")
        /**
        CDMA2000 1XRTT.
        */
        public static let cdma20001xrtt = NetHostConnectionSubtypeValuesObjc("cdma2000_1xrtt")
        /**
        HSDPA.
        */
        public static let hsdpa = NetHostConnectionSubtypeValuesObjc("hsdpa")
        /**
        HSUPA.
        */
        public static let hsupa = NetHostConnectionSubtypeValuesObjc("hsupa")
        /**
        HSPA.
        */
        public static let hspa = NetHostConnectionSubtypeValuesObjc("hspa")
        /**
        IDEN.
        */
        public static let iden = NetHostConnectionSubtypeValuesObjc("iden")
        /**
        EVDO Rev. B.
        */
        public static let evdoB = NetHostConnectionSubtypeValuesObjc("evdo_b")
        /**
        LTE.
        */
        public static let lte = NetHostConnectionSubtypeValuesObjc("lte")
        /**
        EHRPD.
        */
        public static let ehrpd = NetHostConnectionSubtypeValuesObjc("ehrpd")
        /**
        HSPAP.
        */
        public static let hspap = NetHostConnectionSubtypeValuesObjc("hspap")
        /**
        GSM.
        */
        public static let gsm = NetHostConnectionSubtypeValuesObjc("gsm")
        /**
        TD-SCDMA.
        */
        public static let tdScdma = NetHostConnectionSubtypeValuesObjc("td_scdma")
        /**
        IWLAN.
        */
        public static let iwlan = NetHostConnectionSubtypeValuesObjc("iwlan")
        /**
        5G NR (New Radio).
        */
        public static let nr = NetHostConnectionSubtypeValuesObjc("nr")
        /**
        5G NRNSA (New Radio Non-Standalone).
        */
        public static let nrnsa = NetHostConnectionSubtypeValuesObjc("nrnsa")
        /**
        LTE CA.
        */
        public static let lteCa = NetHostConnectionSubtypeValuesObjc("lte_ca")

        internal let value : String

        public init(_ customValue: String) {
            self.value = customValue
        }

        public override var description: String {
            return value
        }
    }
    
    /**
    The kind of message destination.
    */
    /// - Tag: otelMessagingDestinationKindValues
    @objc public class MessagingDestinationKindValuesObjc : NSObject {
        /**
        A message sent to a queue.
        */
        @objc public static var queue = "queue"
        /**
        A message sent to a topic.
        */
        @objc public static var topic = "topic"
    }
    
    /**
    The cloud provider of the invoked function.
    */
    /// - Tag: otelFaasInvokedProviderValues
    @objc public class FaasInvokedProviderValuesObjc: NSObject {
        /**
        Alibaba Cloud.
        */
        public static let alibabaCloud = FaasInvokedProviderValuesObjc("alibaba_cloud")
        /**
        Amazon Web Services.
        */
        public static let aws = FaasInvokedProviderValuesObjc("aws")
        /**
        Microsoft Azure.
        */
        public static let azure = FaasInvokedProviderValuesObjc("azure")
        /**
        Google Cloud Platform.
        */
        public static let gcp = FaasInvokedProviderValuesObjc("gcp")

        internal let value: String

        public init(_ customValue: String) {
            self.value = customValue
        }

        public override var description: String {
            return value
        }
    }
    
    /**
    A string identifying the kind of message consumption as defined in the [Operation names](#operation-names) section above. If the operation is "send", this attribute MUST NOT be set, since the operation can be inferred from the span kind in that @objc public static var.
    */
    /// - Tag: otelMessagingOperationValues
    @objc public class MessagingOperationValuesObjc : NSObject {
        /**
        receive.
        */
        @objc public static var receive = "receive"
        /**
        process.
        */
        @objc public static var process = "process"
    }
    
    /**
    The [numeric status code](https://github.com/grpc/grpc/blob/v1.33.2/doc/statuscodes.md) of the gRPC request.
    */
    /// - Tag: otelRpcGrpcStatusCodeValues
    @objc public class RpcGrpcStatusCodeValuesObjc : NSObject {
        /**
        OK.
        */
        @objc public static var ok = 0
        /**
        CANCELLED.
        */
        @objc public static var cancelled = 1
        /**
        UNKNOWN.
        */
        @objc public static var unknown = 2
        /**
        INVALID_ARGUMENT.
        */
        @objc public static var invalid_argument = 3
        /**
        DEADLINE_EXCEEDED.
        */
        @objc public static var deadline_exceeded = 4
        /**
        NOT_FOUND.
        */
        @objc public static var not_found = 5
        /**
        ALREADY_EXISTS.
        */
        @objc public static var already_exists = 6
        /**
        PERMISSION_DENIED.
        */
        @objc public static var permission_denied = 7
        /**
        RESOURCE_EXHAUSTED.
        */
        @objc public static var resource_exhausted = 8
        /**
        FAILED_PRECONDITION.
        */
        @objc public static var failed_precondition = 9
        /**
        ABORTED.
        */
        @objc public static var aborted = 10
        /**
        OUT_OF_RANGE.
        */
        @objc public static var out_of_range = 11
        /**
        UNIMPLEMENTED.
        */
        @objc public static var unimplemented = 12
        /**
        INTERNAL.
        */
        @objc public static var `internal` = 13
        /**
        UNAVAILABLE.
        */
        @objc public static var unavailable = 14
        /**
        DATA_LOSS.
        */
        @objc public static var data_loss = 15
        /**
        UNAUTHENTICATED.
        */
        @objc public static var unauthenticated = 16
    }
    
    /**
    Whether this is a received or sent message.
    */
    /// - Tag: otelMessageTypeValues
    @objc public class MessageTypeValuesObjc : NSObject {
        /**
        sent.
        */
        @objc public static var sent = "SENT"
        /**
        received.
        */
        @objc public static var received = "RECEIVED"
    }
    
}

