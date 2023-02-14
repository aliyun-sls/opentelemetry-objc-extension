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

public class ResourceAttributesObjc : NSObject {
    /**
    Name of the cloud provider.
    - Requires: Value should be one of [`ResourceAttributes.CloudProviderValuesObjc`](x-source-tag://otelCloudProviderValues) (of type `String`)
    */
    @objc public static var cloudProvider = "cloud.provider"
    /**
    The cloud account ID the resource is assigned to.

    ~~~
    // Examples
    attributes[.cloudAccountId] = "111111111111"
    attributes[.cloudAccountId] = "opentelemetry"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var cloudAccountId = "cloud.account.id"
    /**
    The geographical region the resource is running. Refer to your provider's docs to see the available regions, for example [Alibaba Cloud regions](https://www.alibabacloud.com/help/doc-detail/40654.htm), [AWS regions](https://aws.amazon.com/about-aws/global-infrastructure/regions_az/), [Azure regions](https://azure.microsoft.com/en-us/global-infrastructure/geographies/), or [Google Cloud regions](https://cloud.google.com/about/locations).

    ~~~
    // Examples
    attributes[.cloudRegion] = "us-central1"
    attributes[.cloudRegion] = "us-east-1"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var cloudRegion = "cloud.region"
    /**
    Cloud regions often have multiple, isolated locations known as zones to increase availability. Availability zone represents the zone where the resource is running.

    ~~~
    // Examples
    attributes[.cloudAvailabilityZone] = "us-east-1c"
    ~~~

    - Note: Availability zones are called "zones" on Alibaba Cloud and Google Cloud.
    - Requires: Value type should be `String`
    */
    @objc public static var cloudAvailabilityZone = "cloud.availability_zone"
    /**
    The cloud platform in use.

    - Note: The prefix of the service SHOULD match the one specified in `cloud.provider`.
    - Requires: Value should be one of [`ResourceAttributes.CloudPlatformValuesObjc`](x-source-tag://otelCloudPlatformValues) (of type `String`)
    */
    @objc public static var cloudPlatform = "cloud.platform"
    /**
    The Amazon Resource Name (ARN) of an [ECS container instance](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_instances.html).

    ~~~
    // Examples
    attributes[.awsEcsContainerArn] = "arn:aws:ecs:us-west-1:123456789123:container/32624152-9086-4f0e-acae-1a75b14fe4d9"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var awsEcsContainerArn = "aws.ecs.container.arn"
    /**
    The ARN of an [ECS cluster](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/clusters.html).

    ~~~
    // Examples
    attributes[.awsEcsClusterArn] = "arn:aws:ecs:us-west-2:123456789123:cluster/my-cluster"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var awsEcsClusterArn = "aws.ecs.cluster.arn"
    /**
    The [launch type](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_types.html) for an ECS task.
    - Requires: Value should be one of [`ResourceAttributes.AwsEcsLaunchtypeValues`](x-source-tag://otelAwsEcsLaunchtypeValues) (of type `String`)
    */
    @objc public static var awsEcsLaunchtype = "aws.ecs.launchtype"
    /**
    The ARN of an [ECS task definition](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definitions.html).

    ~~~
    // Examples
    attributes[.awsEcsTaskArn] = "arn:aws:ecs:us-west-1:123456789123:task/10838bed-421f-43ef-870a-f43feacbbb5b"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var awsEcsTaskArn = "aws.ecs.task.arn"
    /**
    The task definition family this task definition is a member of.

    ~~~
    // Examples
    attributes[.awsEcsTaskFamily] = "opentelemetry-family"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var awsEcsTaskFamily = "aws.ecs.task.family"
    /**
    The revision for this task definition.

    ~~~
    // Examples
    attributes[.awsEcsTaskRevision] = "8"
    attributes[.awsEcsTaskRevision] = "26"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var awsEcsTaskRevision = "aws.ecs.task.revision"
    /**
    The ARN of an EKS cluster.

    ~~~
    // Examples
    attributes[.awsEksClusterArn] = "arn:aws:ecs:us-west-2:123456789123:cluster/my-cluster"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var awsEksClusterArn = "aws.eks.cluster.arn"
    /**
    The name(s) of the AWS log group(s) an application is writing to.

    ~~~
    // Examplesattributes[.awsLogGroupNames] = /aws/lambda/my-functionattributes[.awsLogGroupNames] = opentelemetry-service
    ~~~

    - Note: Multiple log groups must be supported for cases like multi-container applications, where a single application has sidecar containers, and each write to their own log group.
    - Requires: Value type should be `[String]`
    */
    @objc public static var awsLogGroupNames = "aws.log.group.names"
    /**
    The Amazon Resource Name(s) (ARN) of the AWS log group(s).

    ~~~
    // Examplesattributes[.awsLogGroupArns] = arn:aws:logs:us-west-1:123456789012:log-group:/aws/my/group:*
    ~~~

    - Note: See the [log group ARN format documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/iam-access-control-overview-cwl.html#CWL_ARN_Format).
    - Requires: Value type should be `[String]`
    */
    @objc public static var awsLogGroupArns = "aws.log.group.arns"
    /**
    The name(s) of the AWS log stream(s) an application is writing to.

    ~~~
    // Examplesattributes[.awsLogStreamNames] = logs/main/10838bed-421f-43ef-870a-f43feacbbb5b
    ~~~
    - Requires: Value type should be `[String]`
    */
    @objc public static var awsLogStreamNames = "aws.log.stream.names"
    /**
    The ARN(s) of the AWS log stream(s).

    ~~~
    // Examplesattributes[.awsLogStreamArns] = arn:aws:logs:us-west-1:123456789012:log-group:/aws/my/group:log-stream:logs/main/10838bed-421f-43ef-870a-f43feacbbb5b
    ~~~

    - Note: See the [log stream ARN format documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/iam-access-control-overview-cwl.html#CWL_ARN_Format). One log group can contain several log streams, so these ARNs necessarily identify both a log group and a log stream.
    - Requires: Value type should be `[String]`
    */
    @objc public static var awsLogStreamArns = "aws.log.stream.arns"
    /**
    Container name.

    ~~~
    // Examples
    attributes[.containerName] = "opentelemetry-autoconf"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var containerName = "container.name"
    /**
    Container ID. Usually a UUID, as for example used to [identify Docker containers](https://docs.docker.com/engine/reference/run/#container-identification). The UUID might be abbreviated.

    ~~~
    // Examples
    attributes[.containerId] = "a3bf90e006b2"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var containerId = "container.id"
    /**
    The container runtime managing this container.

    ~~~
    // Examples
    attributes[.containerRuntime] = "docker"
    attributes[.containerRuntime] = "containerd"
    attributes[.containerRuntime] = "rkt"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var containerRuntime = "container.runtime"
    /**
    Name of the image the container was built on.

    ~~~
    // Examples
    attributes[.containerImageName] = "gcr.io/opentelemetry/operator"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var containerImageName = "container.image.name"
    /**
    Container image tag.

    ~~~
    // Examples
    attributes[.containerImageTag] = "0.1"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var containerImageTag = "container.image.tag"
    /**
    Name of the [deployment environment](https://en.wikipedia.org/wiki/Deployment_environment) (aka deployment tier).

    ~~~
    // Examples
    attributes[.deploymentEnvironment] = "staging"
    attributes[.deploymentEnvironment] = "production"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var deploymentEnvironment = "deployment.environment"
    /**
    A unique identifier representing the device.

    ~~~
    // Examples
    attributes[.deviceId] = "2ab2916d-a51f-4ac8-80ee-45ac31a28092"
    ~~~

    - Note: The device identifier MUST only be defined using the values outlined below. This value is not an advertising identifier and MUST NOT be used as such. On iOS (Swift or Objective-C), this value MUST be equal to the [vendor identifier](https://developer.apple.com/documentation/uikit/uidevice/1620059-identifierforvendor). On Android (Java or Kotlin), this value MUST be equal to the Firebase Installation ID or a globally unique UUID which is persisted across sessions in your application. More information can be found [here](https://developer.android.com/training/articles/user-data-ids) on best practices and exact implementation details. Caution should be taken when storing personal data or anything which can identify a user. GDPR and data protection laws may apply, ensure you do your own due diligence.
    - Requires: Value type should be `String`
    */
    @objc public static var deviceId = "device.id"
    /**
    The model identifier for the device.

    ~~~
    // Examples
    attributes[.deviceModelIdentifier] = "iPhone3,4"
    attributes[.deviceModelIdentifier] = "SM-G920F"
    ~~~

    - Note: It's recommended this value represents a machine readable version of the model identifier rather than the market or consumer-friendly name of the device.
    - Requires: Value type should be `String`
    */
    @objc public static var deviceModelIdentifier = "device.model.identifier"
    /**
    The marketing name for the device model.

    ~~~
    // Examples
    attributes[.deviceModelName] = "iPhone 6s Plus"
    attributes[.deviceModelName] = "Samsung Galaxy S6"
    ~~~

    - Note: It's recommended this value represents a human readable version of the device model rather than a machine readable alternative.
    - Requires: Value type should be `String`
    */
    @objc public static var deviceModelName = "device.model.name"
    /**
    The name of the single function that this runtime instance executes.

    ~~~
    // Examples
    attributes[.faasName] = "my-function"
    ~~~

    - Note: This is the name of the function as configured/deployed on the FaaS platform and is usually different from the name of the callback function (which may be stored in the [`code.namespace`/`code.function`](../../trace/semantic_conventions/span-general.md#source-code-attributes) span attributes).
    - Requires: Value type should be `String`
    */
    @objc public static var faasName = "faas.name"
    /**
    The unique ID of the single function that this runtime instance executes.

    ~~~
    // Examples
    attributes[.faasId] = "arn:aws:lambda:us-west-2:123456789012:function:my-function"
    ~~~

    - Note: Depending on the cloud provider, use:

      * **AWS Lambda:** The function [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
      Take care not to use the "invoked ARN" directly but replace any
      [alias suffix](https://docs.aws.amazon.com/lambda/latest/dg/configuration-aliases.html) with the resolved function version, as the same runtime instance may be invokable with multiple
      different aliases.
      * **GCP:** The [URI of the resource](https://cloud.google.com/iam/docs/full-resource-names)
      * **Azure:** The [Fully Qualified Resource ID](https://docs.microsoft.com/en-us/rest/api/resources/resources/get-by-id).

      On some providers, it may not be possible to determine the full ID at startup,
      which is why this field cannot be made required. For example, on AWS the account ID
      part of the ARN is not available without calling another AWS API
      which may be deemed too slow for a short-running lambda function.
      As an alternative, consider setting `faas.id` as a span attribute instead.
    - Requires: Value type should be `String`
    */
    @objc public static var faasId = "faas.id"
    /**
    The immutable version of the function being executed.

    ~~~
    // Examples
    attributes[.faasVersion] = "26"
    attributes[.faasVersion] = "pinkfroid-00002"
    ~~~

    - Note: Depending on the cloud provider and platform, use:

      * **AWS Lambda:** The [function version](https://docs.aws.amazon.com/lambda/latest/dg/configuration-versions.html)
        (an integer represented as a decimal string).
      * **Google Cloud Run:** The [revision](https://cloud.google.com/run/docs/managing/revisions)
        (i.e., the function name plus the revision suffix).
      * **Google Cloud Functions:** The value of the
        [`K_REVISION` environment variable](https://cloud.google.com/functions/docs/env-var#runtime_environment_variables_set_automatically).
      * **Azure Functions:** Not applicable. Do not set this attribute.
    - Requires: Value type should be `String`
    */
    @objc public static var faasVersion = "faas.version"
    /**
    The execution environment ID as a string, that will be potentially reused for other invocations to the same function/function version.

    ~~~
    // Examples
    attributes[.faasInstance] = "2021/06/28/[$LATEST]2f399eb14537447da05ab2a2e39309de"
    ~~~

    - Note: * **AWS Lambda:** Use the (full) log stream name.
    - Requires: Value type should be `String`
    */
    @objc public static var faasInstance = "faas.instance"
    /**
    The amount of memory available to the serverless function in MiB.

    ~~~
    // Examplesattributes[.faasMaxMemory] = 128
    ~~~

    - Note: It's recommended to set this attribute since e.g. too little memory can easily stop a Java AWS Lambda function from working correctly. On AWS Lambda, the environment variable `AWS_LAMBDA_FUNCTION_MEMORY_SIZE` provides this information.
    - Requires: Value type should be `Int`
    */
    @objc public static var faasMaxMemory = "faas.max_memory"
    /**
    Unique host ID. For Cloud, this must be the instance_id assigned by the cloud provider.

    ~~~
    // Examples
    attributes[.hostId] = "opentelemetry-test"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var hostId = "host.id"
    /**
    Name of the host. On Unix systems, it may contain what the hostname command returns, or the fully qualified hostname, or another name specified by the user.

    ~~~
    // Examples
    attributes[.hostName] = "opentelemetry-test"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var hostName = "host.name"
    /**
    Type of host. For Cloud, this must be the machine type.

    ~~~
    // Examples
    attributes[.hostType] = "n1-standard-1"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var hostType = "host.type"
    /**
    The CPU architecture the host system is running on.
    - Requires: Value should be one of [`ResourceAttributes.HostArchValuesObjc`](x-source-tag://otelHostArchValues) (of type `String`)
    */
    @objc public static var hostArch = "host.arch"
    /**
    Name of the VM image or OS install the host was instantiated from.

    ~~~
    // Examples
    attributes[.hostImageName] = "infra-ami-eks-worker-node-7d4ec78312"
    attributes[.hostImageName] = "CentOS-8-x86_64-1905"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var hostImageName = "host.image.name"
    /**
    VM image ID. For Cloud, this value is from the provider.

    ~~~
    // Examples
    attributes[.hostImageId] = "ami-07b06b442921831e5"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var hostImageId = "host.image.id"
    /**
    The version string of the VM image as defined in [Version Attributes](README.md#version-attributes).

    ~~~
    // Examples
    attributes[.hostImageVersion] = "0.1"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var hostImageVersion = "host.image.version"
    /**
    The name of the cluster.

    ~~~
    // Examples
    attributes[.k8sClusterName] = "opentelemetry-cluster"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sClusterName = "k8s.cluster.name"
    /**
    The name of the Node.

    ~~~
    // Examples
    attributes[.k8sNodeName] = "node-1"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sNodeName = "k8s.node.name"
    /**
    The UID of the Node.

    ~~~
    // Examples
    attributes[.k8sNodeUid] = "1eb3a0c6-0477-4080-a9cb-0cb7db65c6a2"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sNodeUid = "k8s.node.uid"
    /**
    The name of the namespace that the pod is running in.

    ~~~
    // Examples
    attributes[.k8sNamespaceName] = "default"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sNamespaceName = "k8s.namespace.name"
    /**
    The UID of the Pod.

    ~~~
    // Examples
    attributes[.k8sPodUid] = "275ecb36-5aa8-4c2a-9c47-d8bb681b9aff"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sPodUid = "k8s.pod.uid"
    /**
    The name of the Pod.

    ~~~
    // Examples
    attributes[.k8sPodName] = "opentelemetry-pod-autoconf"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sPodName = "k8s.pod.name"
    /**
    The name of the Container in a Pod template.

    ~~~
    // Examples
    attributes[.k8sContainerName] = "redis"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sContainerName = "k8s.container.name"
    /**
    The UID of the ReplicaSet.

    ~~~
    // Examples
    attributes[.k8sReplicasetUid] = "275ecb36-5aa8-4c2a-9c47-d8bb681b9aff"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sReplicasetUid = "k8s.replicaset.uid"
    /**
    The name of the ReplicaSet.

    ~~~
    // Examples
    attributes[.k8sReplicasetName] = "opentelemetry"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sReplicasetName = "k8s.replicaset.name"
    /**
    The UID of the Deployment.

    ~~~
    // Examples
    attributes[.k8sDeploymentUid] = "275ecb36-5aa8-4c2a-9c47-d8bb681b9aff"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sDeploymentUid = "k8s.deployment.uid"
    /**
    The name of the Deployment.

    ~~~
    // Examples
    attributes[.k8sDeploymentName] = "opentelemetry"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sDeploymentName = "k8s.deployment.name"
    /**
    The UID of the StatefulSet.

    ~~~
    // Examples
    attributes[.k8sStatefulsetUid] = "275ecb36-5aa8-4c2a-9c47-d8bb681b9aff"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sStatefulsetUid = "k8s.statefulset.uid"
    /**
    The name of the StatefulSet.

    ~~~
    // Examples
    attributes[.k8sStatefulsetName] = "opentelemetry"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sStatefulsetName = "k8s.statefulset.name"
    /**
    The UID of the DaemonSet.

    ~~~
    // Examples
    attributes[.k8sDaemonsetUid] = "275ecb36-5aa8-4c2a-9c47-d8bb681b9aff"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sDaemonsetUid = "k8s.daemonset.uid"
    /**
    The name of the DaemonSet.

    ~~~
    // Examples
    attributes[.k8sDaemonsetName] = "opentelemetry"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sDaemonsetName = "k8s.daemonset.name"
    /**
    The UID of the Job.

    ~~~
    // Examples
    attributes[.k8sJobUid] = "275ecb36-5aa8-4c2a-9c47-d8bb681b9aff"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sJobUid = "k8s.job.uid"
    /**
    The name of the Job.

    ~~~
    // Examples
    attributes[.k8sJobName] = "opentelemetry"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sJobName = "k8s.job.name"
    /**
    The UID of the CronJob.

    ~~~
    // Examples
    attributes[.k8sCronjobUid] = "275ecb36-5aa8-4c2a-9c47-d8bb681b9aff"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sCronjobUid = "k8s.cronjob.uid"
    /**
    The name of the CronJob.

    ~~~
    // Examples
    attributes[.k8sCronjobName] = "opentelemetry"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var k8sCronjobName = "k8s.cronjob.name"
    /**
    The operating system type.
    - Requires: Value should be one of [`ResourceAttributes.OsTypeValuesObjc`](x-source-tag://otelOsTypeValues) (of type `String`)
    */
    @objc public static var osType = "os.type"
    /**
    Human readable (not intended to be parsed) OS version information, like e.g. reported by `ver` or `lsb_release -a` commands.

    ~~~
    // Examples
    attributes[.osDescription] = "Microsoft Windows [Version 10.0.18363.778]"
    attributes[.osDescription] = "Ubuntu 18.04.1 LTS"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var osDescription = "os.description"
    /**
    Human readable operating system name.

    ~~~
    // Examples
    attributes[.osName] = "iOS"
    attributes[.osName] = "Android"
    attributes[.osName] = "Ubuntu"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var osName = "os.name"
    /**
    The version string of the operating system as defined in [Version Attributes](../../resource/semantic_conventions/README.md#version-attributes).

    ~~~
    // Examples
    attributes[.osVersion] = "14.2.1"
    attributes[.osVersion] = "18.04.1"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var osVersion = "os.version"
    /**
    Process identifier (PID).

    ~~~
    // Examplesattributes[.processPid] = 1234
    ~~~
    - Requires: Value type should be `Int`
    */
    @objc public static var processPid = "process.pid"
    /**
    The name of the process executable. On Linux based systems, can be set to the `Name` in `proc/[pid]/status`. On Windows, can be set to the base name of `GetProcessImageFileNameW`.

    ~~~
    // Examples
    attributes[.processExecutableName] = "otelcol"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var processExecutableName = "process.executable.name"
    /**
    The full path to the process executable. On Linux based systems, can be set to the target of `proc/[pid]/exe`. On Windows, can be set to the result of `GetProcessImageFileNameW`.

    ~~~
    // Examples
    attributes[.processExecutablePath] = "/usr/bin/cmd/otelcol"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var processExecutablePath = "process.executable.path"
    /**
    The command used to launch the process (i.e. the command name). On Linux based systems, can be set to the zeroth string in `proc/[pid]/cmdline`. On Windows, can be set to the first parameter extracted from `GetCommandLineW`.

    ~~~
    // Examples
    attributes[.processCommand] = "cmd/otelcol"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var processCommand = "process.command"
    /**
    The full command used to launch the process as a single string representing the full command. On Windows, can be set to the result of `GetCommandLineW`. Do not set this if you have to assemble it just for monitoring; use `process.command_args` instead.

    ~~~
    // Examples
    attributes[.processCommandLine] = "C:\cmd\otecol --config=\"my directory\config.yaml\""
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var processCommandLine = "process.command_line"
    /**
    All the command arguments (including the command/executable itself) as received by the process. On Linux-based systems (and some other Unixoid systems supporting procfs), can be set according to the list of null-delimited strings extracted from `proc/[pid]/cmdline`. For libc-based executables, this would be the full argv vector passed to `main`.

    ~~~
    // Examplesattributes[.processCommandArgs] = cmd/otecolattributes[.processCommandArgs] = --config=config.yaml
    ~~~
    - Requires: Value type should be `[String]`
    */
    @objc public static var processCommandArgs = "process.command_args"
    /**
    The username of the user that owns the process.

    ~~~
    // Examples
    attributes[.processOwner] = "root"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var processOwner = "process.owner"
    /**
    The name of the runtime of this process. For compiled native binaries, this SHOULD be the name of the compiler.

    ~~~
    // Examples
    attributes[.processRuntimeName] = "OpenJDK Runtime Environment"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var processRuntimeName = "process.runtime.name"
    /**
    The version of the runtime of this process, as returned by the runtime without modification.

    ~~~
    // Examples
    attributes[.processRuntimeVersion] = "14.0.2"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var processRuntimeVersion = "process.runtime.version"
    /**
    An additional description about the runtime of the process, for example a specific vendor customization of the runtime environment.

    ~~~
    // Examples
    attributes[.processRuntimeDescription] = "Eclipse OpenJ9 Eclipse OpenJ9 VM openj9-0.21.0"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var processRuntimeDescription = "process.runtime.description"
    /**
    Logical name of the service.

    ~~~
    // Examples
    attributes[.serviceName] = "shoppingcart"
    ~~~

    - Note: MUST be the same for all instances of horizontally scaled services. If the value was not specified, SDKs MUST fallback to `unknown_service:` concatenated with [`process.executable.name`](process.md#process), e.g. `unknown_service:bash`. If `process.executable.name` is not available, the value MUST be set to `unknown_service`.
    - Requires: Value type should be `String`
    */
    @objc public static var serviceName = "service.name"
    /**
    A namespace for `service.name`.

    ~~~
    // Examples
    attributes[.serviceNamespace] = "Shop"
    ~~~

    - Note: A string value having a meaning that helps to distinguish a group of services, for example the team name that owns a group of services. `service.name` is expected to be unique within the same namespace. If `service.namespace` is not specified in the Resource then `service.name` is expected to be unique for all services that have no explicit namespace defined (so the empty/unspecified namespace is simply one more valid namespace). Zero-length namespace string is assumed equal to unspecified namespace.
    - Requires: Value type should be `String`
    */
    @objc public static var serviceNamespace = "service.namespace"
    /**
    The string ID of the service instance.

    ~~~
    // Examples
    attributes[.serviceInstanceId] = "627cc493-f310-47de-96bd-71410b7dec09"
    ~~~

    - Note: MUST be unique for each instance of the same `service.namespace,service.name` pair (in other words `service.namespace,service.name,service.instance.id` triplet MUST be globally unique). The ID helps to distinguish instances of the same service that exist at the same time (e.g. instances of a horizontally scaled service). It is preferable for the ID to be persistent and stay the same for the lifetime of the service instance, however it is acceptable that the ID is ephemeral and changes during important lifetime events for the service (e.g. service restarts). If the service has no inherent unique ID that can be used as the value of this attribute it is recommended to generate a random Version 1 or Version 4 RFC 4122 UUID (services aiming for reproducible UUIDs may also use Version 5, see RFC 4122 for more recommendations).
    - Requires: Value type should be `String`
    */
    @objc public static var serviceInstanceId = "service.instance.id"
    /**
    The version string of the service API or implementation.

    ~~~
    // Examples
    attributes[.serviceVersion] = "2.0.0"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var serviceVersion = "service.version"
    /**
    The name of the telemetry SDK as defined above.

    ~~~
    // Examples
    attributes[.telemetrySdkName] = "opentelemetry"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var telemetrySdkName = "telemetry.sdk.name"
    /**
    The language of the telemetry SDK.
    - Requires: Value should be one of [`ResourceAttributes.TelemetrySdkLanguageValuesObjc`](x-source-tag://otelTelemetrySdkLanguageValues) (of type `String`)
    */
    @objc public static var telemetrySdkLanguage = "telemetry.sdk.language"
    /**
    The version string of the telemetry SDK.

    ~~~
    // Examples
    attributes[.telemetrySdkVersion] = "1.2.3"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var telemetrySdkVersion = "telemetry.sdk.version"
    /**
    The version string of the auto instrumentation agent, if used.

    ~~~
    // Examples
    attributes[.telemetryAutoVersion] = "1.2.3"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var telemetryAutoVersion = "telemetry.auto.version"
    /**
    The name of the web engine.

    ~~~
    // Examples
    attributes[.webengineName] = "WildFly"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var webengineName = "webengine.name"
    /**
    The version of the web engine.

    ~~~
    // Examples
    attributes[.webengineVersion] = "21.0.0"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var webengineVersion = "webengine.version"
    /**
    Additional description of the web engine (e.g. detailed version and edition information).

    ~~~
    // Examples
    attributes[.webengineDescription] = "WildFly Full 21.0.0.Final (WildFly Core 13.0.1.Final) - 2.2.2.Final"
    ~~~
    - Requires: Value type should be `String`
    */
    @objc public static var webengineDescription = "webengine.description"
    
    /**
    Name of the cloud provider.
    */
    /// - Tag: otelCloudProviderValues
    @objc public class CloudProviderValuesObjc : NSObject {
        /**
        Alibaba Cloud.
        */
        public static let alibabaCloud = CloudProviderValuesObjc("alibaba_cloud")
        /**
        Amazon Web Services.
        */
        public static let aws = CloudProviderValuesObjc("aws")
        /**
        Microsoft Azure.
        */
        public static let azure = CloudProviderValuesObjc("azure")
        /**
        Google Cloud Platform.
        */
        public static let gcp = CloudProviderValuesObjc("gcp")

        internal let value: String

        public init(_ customValue: String) {
            self.value = customValue
        }

        public override var description: String {
            return value
        }
    }
    
    /**
    The cloud platform in use.
    */
    /// - Tag: otelCloudPlatformValues
    @objc public class CloudPlatformValuesObjc : NSObject {
        /**
        Alibaba Cloud Elastic Compute Service.
        */
        public static let alibabaCloudEcs = CloudPlatformValuesObjc("alibaba_cloud_ecs")
        /**
        Alibaba Cloud Function Compute.
        */
        public static let alibabaCloudFc = CloudPlatformValuesObjc("alibaba_cloud_fc")
        /**
        AWS Elastic Compute Cloud.
        */
        public static let awsEc2 = CloudPlatformValuesObjc("aws_ec2")
        /**
        AWS Elastic Container Service.
        */
        public static let awsEcs = CloudPlatformValuesObjc("aws_ecs")
        /**
        AWS Elastic Kubernetes Service.
        */
        public static let awsEks = CloudPlatformValuesObjc("aws_eks")
        /**
        AWS Lambda.
        */
        public static let awsLambda = CloudPlatformValuesObjc("aws_lambda")
        /**
        AWS Elastic Beanstalk.
        */
        public static let awsElasticBeanstalk = CloudPlatformValuesObjc("aws_elastic_beanstalk")
        /**
        Azure Virtual Machines.
        */
        public static let azureVm = CloudPlatformValuesObjc("azure_vm")
        /**
        Azure Container Instances.
        */
        public static let azureContainerInstances = CloudPlatformValuesObjc("azure_container_instances")
        /**
        Azure Kubernetes Service.
        */
        public static let azureAks = CloudPlatformValuesObjc("azure_aks")
        /**
        Azure Functions.
        */
        public static let azureFunctions = CloudPlatformValuesObjc("azure_functions")
        /**
        Azure App Service.
        */
        public static let azureAppService = CloudPlatformValuesObjc("azure_app_service")
        /**
        Google Cloud Compute Engine (GCE).
        */
        public static let gcpComputeEngine = CloudPlatformValuesObjc("gcp_compute_engine")
        /**
        Google Cloud Run.
        */
        public static let gcpCloudRun = CloudPlatformValuesObjc("gcp_cloud_run")
        /**
        Google Cloud Kubernetes Engine (GKE).
        */
        public static let gcpKubernetesEngine = CloudPlatformValuesObjc("gcp_kubernetes_engine")
        /**
        Google Cloud Functions (GCF).
        */
        public static let gcpCloudFunctions = CloudPlatformValuesObjc("gcp_cloud_functions")
        /**
        Google Cloud App Engine (GAE).
        */
        public static let gcpAppEngine = CloudPlatformValuesObjc("gcp_app_engine")

        internal let value: String

        public init(_ customValue: String) {
            self.value = customValue
        }

        public override var description: String {
            return value
        }
    }
    
    /**
    The [launch type](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_types.html) for an ECS task.
    */
    /// - Tag: otelAwsEcsLaunchtypeValues
    public class AwsEcsLaunchtypeValuesObjc : NSObject {
        /**
        ec2.
        */
        @objc public static var ec2 = "ec2"
        /**
        fargate.
        */
        @objc public static var fargate = "fargate"
    }
    
    /**
    The CPU architecture the host system is running on.
    */
    /// - Tag: otelHostArchValues
    @objc public class HostArchValuesObjc : NSObject {
        /**
        AMD64.
        */
        public static let amd64 = HostArchValuesObjc("amd64")
        /**
        ARM32.
        */
        public static let arm32 = HostArchValuesObjc("arm32")
        /**
        ARM64.
        */
        public static let arm64 = HostArchValuesObjc("arm64")
        /**
        Itanium.
        */
        public static let ia64 = HostArchValuesObjc("ia64")
        /**
        32-bit PowerPC.
        */
        public static let ppc32 = HostArchValuesObjc("ppc32")
        /**
        64-bit PowerPC.
        */
        public static let ppc64 = HostArchValuesObjc("ppc64")
        /**
        32-bit x86.
        */
        public static let x86 = HostArchValuesObjc("x86")

        internal let value: String

        public init(_ customValue: String) {
            self.value = customValue
        }

        public override var description: String {
            return value
        }
    }
    
    /**
    The operating system type.
    */
    /// - Tag: otelOsTypeValues
    @objc public class OsTypeValuesObjc : NSObject {
        /**
        Microsoft Windows.
        */
        public static let windows = OsTypeValuesObjc("windows")
        /**
        Linux.
        */
        public static let linux = OsTypeValuesObjc("linux")
        /**
        Apple Darwin.
        */
        public static let darwin = OsTypeValuesObjc("darwin")
        /**
        FreeBSD.
        */
        public static let freebsd = OsTypeValuesObjc("freebsd")
        /**
        NetBSD.
        */
        public static let netbsd = OsTypeValuesObjc("netbsd")
        /**
        OpenBSD.
        */
        public static let openbsd = OsTypeValuesObjc("openbsd")
        /**
        DragonFly BSD.
        */
        public static let dragonflybsd = OsTypeValuesObjc("dragonflybsd")
        /**
        HP-UX (Hewlett Packard Unix).
        */
        public static let hpux = OsTypeValuesObjc("hpux")
        /**
        AIX (Advanced Interactive eXecutive).
        */
        public static let aix = OsTypeValuesObjc("aix")
        /**
        Oracle Solaris.
        */
        public static let solaris = OsTypeValuesObjc("solaris")
        /**
        IBM z/OS.
        */
        public static let zOs = OsTypeValuesObjc("z_os")

        internal let value: String

        public init(_ customValue: String) {
            self.value = customValue
        }

        public override var description: String {
            return value
        }
    }
    
    /**
    The language of the telemetry SDK.
    */
    /// - Tag: otelTelemetrySdkLanguageValues
    @objc public class TelemetrySdkLanguageValuesObjc : NSObject {
        /**
        cpp.
        */
        public static let cpp = TelemetrySdkLanguageValuesObjc("cpp")
        /**
        dotnet.
        */
        public static let dotnet = TelemetrySdkLanguageValuesObjc("dotnet")
        /**
        erlang.
        */
        public static let erlang = TelemetrySdkLanguageValuesObjc("erlang")
        /**
        go.
        */
        public static let go = TelemetrySdkLanguageValuesObjc("go")
        /**
        java.
        */
        public static let java = TelemetrySdkLanguageValuesObjc("java")
        /**
        nodejs.
        */
        public static let nodejs = TelemetrySdkLanguageValuesObjc("nodejs")
        /**
        php.
        */
        public static let php = TelemetrySdkLanguageValuesObjc("php")
        /**
        python.
        */
        public static let python = TelemetrySdkLanguageValuesObjc("python")
        /**
        ruby.
        */
        public static let ruby = TelemetrySdkLanguageValuesObjc("ruby")
        /**
        webjs.
        */
        public static let webjs = TelemetrySdkLanguageValuesObjc("webjs")
        /**
        swift.
        */
        public static let swift = TelemetrySdkLanguageValuesObjc("swift")

        internal let value: String

        public init(_ customValue: String) {
            self.value = customValue
        }

        public override var description: String {
            return value
        }
    }
    
}
