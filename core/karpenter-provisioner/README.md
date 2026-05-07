# Karpenter Provisioner
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.16.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.16.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_launch_template"></a> [launch\_template](#module\_launch\_template) | ../../../eks/core/workers/launch-template | n/a |

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.provisioner](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_vpc_security_group_ids"></a> [additional\_vpc\_security\_group\_ids](#input\_additional\_vpc\_security\_group\_ids) | A list of security group IDs to associate | `list(string)` | `[]` | no |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | The AMI from which to launch the instance. If not supplied, EKS will use its own default image | `string` | `null` | no |
| <a name="input_annotations"></a> [annotations](#input\_annotations) | Annotations to be applied to K8S resources. | `map(string)` | `{}` | no |
| <a name="input_architecture"></a> [architecture](#input\_architecture) | Identifies the architecture. | `string` | `"amd64"` | no |
| <a name="input_block_device_mappings"></a> [block\_device\_mappings](#input\_block\_device\_mappings) | Specify volumes to attach to the instance besides the volumes specified by the AMI | <pre>list(object({<br>    device_name : string<br>    no_device : optional(string)<br>    virtual_name : optional(string)<br>    ebs : list(object({<br>      kms_key_id : optional(string)<br>      iops : optional(number)<br>      throughput : optional(number)<br>      snapshot_id : optional(string)<br>      volume_size : number<br>      volume_type : string<br>    }))<br>  }))</pre> | <pre>[<br>  {<br>    "device_name": "/dev/sda1",<br>    "ebs": [<br>      {<br>        "volume_size": 100,<br>        "volume_type": "gp3"<br>      }<br>    ]<br>  }<br>]</pre> | no |
| <a name="input_bootstrap_extra_args"></a> [bootstrap\_extra\_args](#input\_bootstrap\_extra\_args) | Additional arguments passed to the bootstrap script. When `platform` = `bottlerocket`; these are additional [settings](https://github.com/bottlerocket-os/bottlerocket#settings) that are provided to the Bottlerocket user data | `string` | `""` | no |
| <a name="input_cluster_security_group_id"></a> [cluster\_security\_group\_id](#input\_cluster\_security\_group\_id) | ID of the cluster security group. | `string` | n/a | yes |
| <a name="input_create_launch_template"></a> [create\_launch\_template](#input\_create\_launch\_template) | Whether to create a new launch template or use one already created. | `bool` | `true` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | If true, the launched EC2 instance(s) will be EBS-optimized | `bool` | `null` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster to deploy into. | `string` | n/a | yes |
| <a name="input_eks_cluster_auth_base64"></a> [eks\_cluster\_auth\_base64](#input\_eks\_cluster\_auth\_base64) | Base64 encoded CA of associated EKS cluster | `string` | `""` | no |
| <a name="input_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#input\_eks\_cluster\_endpoint) | EKS cluster endpoint. | `string` | `""` | no |
| <a name="input_eks_cluster_service_ipv4_cidr"></a> [eks\_cluster\_service\_ipv4\_cidr](#input\_eks\_cluster\_service\_ipv4\_cidr) | The CIDR block to assign Kubernetes service IP addresses from. If you don't specify a block, Kubernetes assigns addresses from either the 10.100.0.0/16 or 172.20.0.0/16 CIDR blocks | `string` | `null` | no |
| <a name="input_enable_bootstrap_user_data"></a> [enable\_bootstrap\_user\_data](#input\_enable\_bootstrap\_user\_data) | Determines whether the bootstrap configurations are populated within the user data template | `bool` | `true` | no |
| <a name="input_enable_consolidation"></a> [enable\_consolidation](#input\_enable\_consolidation) | Requires Karpenter v0.15+. Whether to enable consolidation of worker nodes. This will cause the module to ignore the value of `seconds_after_empty` as these options are mutually exclusive. | `bool` | `false` | no |
| <a name="input_enable_monitoring"></a> [enable\_monitoring](#input\_enable\_monitoring) | Enables/disables detailed monitoring | `bool` | `true` | no |
| <a name="input_gpu_support"></a> [gpu\_support](#input\_gpu\_support) | Identifies if the IAM needs GPU support. | `bool` | `false` | no |
| <a name="input_instance_profile_arn"></a> [instance\_profile\_arn](#input\_instance\_profile\_arn) | Instance profile ARN to add to the launch template. | `string` | `null` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | The K8S version of the cluster. Mandatory if `use_aws_ami` is defined. | `string` | `""` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Key Pair to use for the instance | `string` | `null` | no |
| <a name="input_kubelet_config"></a> [kubelet\_config](#input\_kubelet\_config) | Additional kubelet configurations to be applied. | `map(string)` | `{}` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to be applied to K8S resources. | `map(string)` | `{}` | no |
| <a name="input_launch_template_default_version"></a> [launch\_template\_default\_version](#input\_launch\_template\_default\_version) | Default version of the launch template | `string` | `null` | no |
| <a name="input_launch_template_name"></a> [launch\_template\_name](#input\_launch\_template\_name) | Name of the launch template. If no one is specified it will use the group name as prefix. | `string` | `null` | no |
| <a name="input_launch_template_tags"></a> [launch\_template\_tags](#input\_launch\_template\_tags) | A map of additional tags to add to the tag\_specifications of launch template created | `map(string)` | `{}` | no |
| <a name="input_limit_cpu"></a> [limit\_cpu](#input\_limit\_cpu) | CPU limit for the provisioner. | `string` | `"100"` | no |
| <a name="input_limit_memory"></a> [limit\_memory](#input\_limit\_memory) | Memory limit for the provisioner. | `string` | `"100Gi"` | no |
| <a name="input_node_labels"></a> [node\_labels](#input\_node\_labels) | Labels to be applied to the created nodes. | `map(string)` | `{}` | no |
| <a name="input_node_tags"></a> [node\_tags](#input\_node\_tags) | Tags to be applied to created nodes by karpenter. | `map(string)` | `{}` | no |
| <a name="input_platform"></a> [platform](#input\_platform) | Identifies if the OS platform is `bottlerocket` or `linux` based; | `string` | `"linux"` | no |
| <a name="input_post_bootstrap_user_data"></a> [post\_bootstrap\_user\_data](#input\_post\_bootstrap\_user\_data) | User data that is appended to the user data script after of the EKS bootstrap script. Not used when `platform` = `bottlerocket` | `string` | `""` | no |
| <a name="input_pre_bootstrap_user_data"></a> [pre\_bootstrap\_user\_data](#input\_pre\_bootstrap\_user\_data) | User data that is injected into the user data script ahead of the EKS bootstrap script. Not used when `platform` = `bottlerocket` | `string` | `""` | no |
| <a name="input_provisioner_name"></a> [provisioner\_name](#input\_provisioner\_name) | Name of the Karpenter provisioner. | `string` | n/a | yes |
| <a name="input_registry_mirrors"></a> [registry\_mirrors](#input\_registry\_mirrors) | Enables image registry mirror to avoid dockerhub limits. Only available for bottlerocket. | `list(string)` | `[]` | no |
| <a name="input_requirements"></a> [requirements](#input\_requirements) | Karpenter Requirements. | <pre>list(object({<br>    key : string<br>    operator : string<br>    values : list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_seconds_after_empty"></a> [seconds\_after\_empty](#input\_seconds\_after\_empty) | Setting a value here enables Karpenter to delete empty/unnecessary instances. | `number` | `30` | no |
| <a name="input_seconds_until_expired"></a> [seconds\_until\_expired](#input\_seconds\_until\_expired) | Setting a value here enables node expiry. This enables nodes to effectively be periodically “upgraded” by replacing them with newly provisioned instances. | `number` | `null` | no |
| <a name="input_spot_max_price"></a> [spot\_max\_price](#input\_spot\_max\_price) | The maximum hourly price you're willing to pay for the Spot Instances. | `number` | `null` | no |
| <a name="input_startup_taints"></a> [startup\_taints](#input\_startup\_taints) | Temporary taints to be applied, after node is initialized they're deleted. | <pre>list(object({<br>    key    = string,<br>    value  = string,<br>    effect = string<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to resources. | `map(string)` | n/a | yes |
| <a name="input_taints"></a> [taints](#input\_taints) | The Kubernetes taints to be applied to the nodes created by this provisioner. | <pre>list(object({<br>    key    = string,<br>    value  = string,<br>    effect = string<br>  }))</pre> | `[]` | no |
| <a name="input_update_launch_template_default_version"></a> [update\_launch\_template\_default\_version](#input\_update\_launch\_template\_default\_version) | Whether to update the launch templates default version on each update. Conflicts with `launch_template_default_version` | `bool` | `true` | no |
| <a name="input_use_launch_template"></a> [use\_launch\_template](#input\_use\_launch\_template) | Whether to use a launch template on the Provisioner | `bool` | `true` | no |
| <a name="input_use_spot"></a> [use\_spot](#input\_use\_spot) | Enable spot instances. This will allow the cluster to use spot instances when available. | `bool` | `false` | no |
| <a name="input_user_data_template_path"></a> [user\_data\_template\_path](#input\_user\_data\_template\_path) | Path to a local, custom user data template file to use when rendering user data | `string` | `""` | no |
| <a name="input_workers_security_group_id"></a> [workers\_security\_group\_id](#input\_workers\_security\_group\_id) | ID of the security group for the worker nodes. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
