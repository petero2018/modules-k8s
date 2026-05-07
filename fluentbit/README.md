# fluentbit

Install [fluentbit](https://fluentbit.io/) helm chart.
And setup fluentbit to capture logs from the kubernetes cluster.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_irsa"></a> [irsa](#module\_irsa) | ../../eks/irsa | n/a |
| <a name="module_release"></a> [release](#module\_release) | ../helm-release | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.s3_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_ignore"></a> [application\_ignore](#input\_application\_ignore) | Ignore containers with those names. | `list(string)` | <pre>[<br>  "fluentbit"<br>]</pre> | no |
| <a name="input_application_tag"></a> [application\_tag](#input\_application\_tag) | Application tag prefix. Tag applied to all containers not matching a group. | `string` | `"application"` | no |
| <a name="input_argocd_app_config"></a> [argocd\_app\_config](#input\_argocd\_app\_config) | ArgoCD Application config. See k8s/argocd/resources/application | `any` | `{}` | no |
| <a name="input_aws_metadata_config"></a> [aws\_metadata\_config](#input\_aws\_metadata\_config) | AWS metadata configuration. | <pre>object({<br>    az                = bool<br>    ec2_instance_id   = bool<br>    ec2_instance_type = bool<br>    private_ip        = bool<br>    ami_id            = bool<br>    account_id        = bool<br>    hostname          = bool<br>    vpc_id            = bool<br>    imds_version      = string<br>  })</pre> | <pre>{<br>  "account_id": false,<br>  "ami_id": false,<br>  "az": true,<br>  "ec2_instance_id": true,<br>  "ec2_instance_type": true,<br>  "hostname": false,<br>  "imds_version": "v2",<br>  "private_ip": false,<br>  "vpc_id": false<br>}</pre> | no |
| <a name="input_aws_metadata_enabled"></a> [aws\_metadata\_enabled](#input\_aws\_metadata\_enabled) | Adds AWS metadata to the logs. | `bool` | `true` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region where to deploy. | `string` | n/a | yes |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The Helm Release Version to install. | `string` | n/a | yes |
| <a name="input_container_config"></a> [container\_config](#input\_container\_config) | Container logs input configuration. | <pre>object({<br>    parser           = string # Parser to use for applications<br>    mem_buf_limit    = string # Buffer memory limit<br>    skip_long_lines  = bool   # Avoids stop monitoring on buffer overflow for a line<br>    refresh_interval = number # The interval of refreshing the list of watched files in seconds.<br>    rotate_wait      = number # grace period for rotated files<br>  })</pre> | <pre>{<br>  "mem_buf_limit": "5MB",<br>  "parser": "cri",<br>  "refresh_interval": 10,<br>  "rotate_wait": 30,<br>  "skip_long_lines": true<br>}</pre> | no |
| <a name="input_container_groups"></a> [container\_groups](#input\_container\_groups) | Container groups. key is the tag and the value the list of containers (with wildcards *). | `map(list(string))` | `{}` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. | `bool` | `true` | no |
| <a name="input_dataplane_container_ignore"></a> [dataplane\_container\_ignore](#input\_dataplane\_container\_ignore) | Container list to ignore. | `list(string)` | `[]` | no |
| <a name="input_dataplane_containers"></a> [dataplane\_containers](#input\_dataplane\_containers) | Container prefix for dataplane services. | `list(string)` | <pre>[<br>  "aws-node",<br>  "kube-proxy"<br>]</pre> | no |
| <a name="input_dataplane_logs_enabled"></a> [dataplane\_logs\_enabled](#input\_dataplane\_logs\_enabled) | Capture dataplane logs. | `bool` | `true` | no |
| <a name="input_dataplane_tag"></a> [dataplane\_tag](#input\_dataplane\_tag) | Dataplane logs tag. | `string` | `"dataplane"` | no |
| <a name="input_debug_output_enabled"></a> [debug\_output\_enabled](#input\_debug\_output\_enabled) | Enables debug output (stdout). | `bool` | `false` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | EKS cluster name, needed to wait resource creation. | `string` | n/a | yes |
| <a name="input_host_config"></a> [host\_config](#input\_host\_config) | Input configuration for host files. | <pre>object({<br>    tag_prefix       = string # Tag to use for host logs as a prefix<br>    parser           = string # Parser to use for host files<br>    skip_long_lines  = bool   # Avoids stop monitoring on buffer overflow for a line<br>    mem_buf_limit    = string # Buffer memory limit (on each file)<br>    refresh_interval = number # The interval of refreshing the list of watched files in seconds.<br>  })</pre> | <pre>{<br>  "mem_buf_limit": "5MB",<br>  "parser": "syslog",<br>  "refresh_interval": 10,<br>  "skip_long_lines": true,<br>  "tag_prefix": "host"<br>}</pre> | no |
| <a name="input_host_logs"></a> [host\_logs](#input\_host\_logs) | Host logs to capture. | `map(string)` | <pre>{<br>  "dmesg": "/var/log/dmesg",<br>  "messages": "/var/log/messages",<br>  "secure": "/var/log/secure"<br>}</pre> | no |
| <a name="input_host_logs_enabled"></a> [host\_logs\_enabled](#input\_host\_logs\_enabled) | Capture logs from host. | `bool` | `true` | no |
| <a name="input_kafka_brokers"></a> [kafka\_brokers](#input\_kafka\_brokers) | Kafka bootstrap brokers string. | `string` | `null` | no |
| <a name="input_kafka_output_enabled"></a> [kafka\_output\_enabled](#input\_kafka\_output\_enabled) | Enables the Kafka output. | `bool` | `false` | no |
| <a name="input_kafka_password"></a> [kafka\_password](#input\_kafka\_password) | Kafka SCRAM password. | `string` | `null` | no |
| <a name="input_kafka_topic"></a> [kafka\_topic](#input\_kafka\_topic) | Kafka topic to write logs. | `string` | `null` | no |
| <a name="input_kafka_username"></a> [kafka\_username](#input\_kafka\_username) | Kafka SCRAM username. | `string` | `null` | no |
| <a name="input_kubernetes_metadata_config"></a> [kubernetes\_metadata\_config](#input\_kubernetes\_metadata\_config) | Which Extra Kubernetes metadata should be added to log events. | <pre>object({<br>    labels      = bool<br>    annotations = bool<br>  })</pre> | <pre>{<br>  "annotations": true,<br>  "labels": true<br>}</pre> | no |
| <a name="input_kubernetes_metadata_enabled"></a> [kubernetes\_metadata\_enabled](#input\_kubernetes\_metadata\_enabled) | Adds Kubernetes metadata to the logs. | `bool` | `true` | no |
| <a name="input_manage_via_argocd"></a> [manage\_via\_argocd](#input\_manage\_via\_argocd) | Determines if the release should be managed via ArgoCD. | `bool` | `false` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the components in. | `string` | `"fluentbit"` | no |
| <a name="input_opensearch_host"></a> [opensearch\_host](#input\_opensearch\_host) | Hostname of the target OpenSearch instance. | `string` | `null` | no |
| <a name="input_opensearch_index"></a> [opensearch\_index](#input\_opensearch\_index) | Index name. | `string` | `"k8s"` | no |
| <a name="input_opensearch_output_enabled"></a> [opensearch\_output\_enabled](#input\_opensearch\_output\_enabled) | Enables OpenSearch Output. | `bool` | `true` | no |
| <a name="input_parsers"></a> [parsers](#input\_parsers) | Fluentbit parsers | <pre>map(object({<br>    format      = string<br>    regex       = optional(string)<br>    time_key    = string<br>    time_format = string<br>  }))</pre> | <pre>{<br>  "cri": {<br>    "format": "regex",<br>    "regex": "^(?<time>[^ ]+) (?<stream>stdout|stderr) (?<logtag>[^ ]*) (?<log>.*)$\n",<br>    "time_format": "%Y-%m-%dT%H:%M:%S.%L%z",<br>    "time_key": "time"<br>  },<br>  "syslog": {<br>    "format": "regex",<br>    "regex": "^(?<time>[^ ]* {1,2}[^ ]* [^ ]*) (?<host>[^ ]*) (?<ident>[a-zA-Z0-9_\\/\\.\\-]*)(?:\\[(?<pid>[0-9]+)\\])?(?:[^\\:]*\\:)? *(?<message>.*)$\n",<br>    "time_format": "%b %d %H:%M:%S",<br>    "time_key": "time"<br>  }<br>}</pre> | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | S3 Bucket to store data. | `string` | `null` | no |
| <a name="input_s3_compression"></a> [s3\_compression](#input\_s3\_compression) | Compression to use on the files. | `string` | `"gzip"` | no |
| <a name="input_s3_file_size"></a> [s3\_file\_size](#input\_s3\_file\_size) | Specifies the size of files in S3. | `string` | `"50M"` | no |
| <a name="input_s3_key_format"></a> [s3\_key\_format](#input\_s3\_key\_format) | Key format to use after key prefix. | `string` | `"%Y/%m/%d/%H_%M_%S/$TAG-$UUID.gz"` | no |
| <a name="input_s3_key_prefix"></a> [s3\_key\_prefix](#input\_s3\_key\_prefix) | S3 Key Prefix to use. | `string` | `"k8s"` | no |
| <a name="input_s3_output_enabled"></a> [s3\_output\_enabled](#input\_s3\_output\_enabled) | Enables S3 Output. | `bool` | `true` | no |
| <a name="input_static_fields"></a> [static\_fields](#input\_static\_fields) | Map of static fields to add to all logs. | `map(string)` | `{}` | no |
| <a name="input_systemd_logs_enabled"></a> [systemd\_logs\_enabled](#input\_systemd\_logs\_enabled) | Capture logs from systemd. | `bool` | `true` | no |
| <a name="input_systemd_tag"></a> [systemd\_tag](#input\_systemd\_tag) | Systemd tag prefix. | `string` | `"systemd"` | no |
| <a name="input_systemd_units"></a> [systemd\_units](#input\_systemd\_units) | Dataplane Systemd units. Empty list capture all logs. | `list(string)` | <pre>[<br>  "docker.service",<br>  "kubelet.service"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to AWS resources. | `map(string)` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for release installation. | `number` | `600` | no |
| <a name="input_tolerations"></a> [tolerations](#input\_tolerations) | Set fluentbit tolerations. | <pre>list(object({<br>    key      = string<br>    operator = string<br>    effect   = string<br>  }))</pre> | <pre>[<br>  {<br>    "effect": "NoExecute",<br>    "key": "dedicated",<br>    "operator": "Exists"<br>  },<br>  {<br>    "effect": "NoExecute",<br>    "key": "jenkins",<br>    "operator": "Exists"<br>  },<br>  {<br>    "effect": "NoExecute",<br>    "key": "architecture",<br>    "operator": "Exists"<br>  }<br>]</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
