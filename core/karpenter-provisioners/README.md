# karpenter-provisioners

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_provisioner"></a> [provisioner](#module\_provisioner) | ../karpenter-provisioner | n/a |
| <a name="module_spot_provisioner"></a> [spot\_provisioner](#module\_spot\_provisioner) | ../karpenter-provisioner | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_security_group_id"></a> [cluster\_security\_group\_id](#input\_cluster\_security\_group\_id) | ID of the cluster security group. | `string` | n/a | yes |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Cluster Name | `string` | n/a | yes |
| <a name="input_eks_cluster_auth_base64"></a> [eks\_cluster\_auth\_base64](#input\_eks\_cluster\_auth\_base64) | Base64 encoded CA of associated EKS cluster | `string` | n/a | yes |
| <a name="input_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#input\_eks\_cluster\_endpoint) | EKS cluster endpoint. | `string` | n/a | yes |
| <a name="input_instance_profile_arn"></a> [instance\_profile\_arn](#input\_instance\_profile\_arn) | Instance profile ARN to add to the launch template. | `string` | `null` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.21`) | `string` | `null` | no |
| <a name="input_provisioner_enable_spot"></a> [provisioner\_enable\_spot](#input\_provisioner\_enable\_spot) | Enable Spot Provisioners. Creates a spot version of each provisioner. | `bool` | `true` | no |
| <a name="input_provisioners"></a> [provisioners](#input\_provisioners) | Karpenter Provisioners | <pre>map(object({<br>    use_spot              = optional(bool)<br>    architecture          = optional(string)<br>    gpu_support           = optional(bool)<br>    platform              = optional(string)<br>    key_name              = optional(string)<br>    seconds_after_empty   = optional(number)<br>    seconds_until_expired = optional(number)<br>    requirements = list(object({<br>      key : string<br>      operator : string<br>      values : list(string)<br>    }))<br>    block_device_mappings = optional(list(object({<br>      device_name : string<br>      no_device : optional(string)<br>      virtual_name : optional(string)<br>      ebs : list(object({<br>        kms_key_id : optional(string)<br>        iops : optional(number)<br>        throughput : optional(number)<br>        snapshot_id : optional(string)<br>        volume_size : number<br>        volume_type : string<br>      }))<br>    })))<br>    limit_cpu    = optional(string)<br>    limit_memory = optional(string)<br>    node_labels  = optional(map(string))<br>    taints = optional(list(object({<br>      key    = string,<br>      value  = string,<br>      effect = string<br>    })))<br>    node_tags = optional(map(string))<br>  }))</pre> | `{}` | no |
| <a name="input_registry_mirrors"></a> [registry\_mirrors](#input\_registry\_mirrors) | Enables image registry mirror to avoid dockerhub limits. Only available for bottlerocket. | `list(string)` | `[]` | no |
| <a name="input_startup_taints"></a> [startup\_taints](#input\_startup\_taints) | Temporary taints to be applied, after node is initialized they're deleted. | <pre>list(object({<br>    key    = string,<br>    value  = string,<br>    effect = string<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to resources. | `map(string)` | n/a | yes |
| <a name="input_workers_security_group_id"></a> [workers\_security\_group\_id](#input\_workers\_security\_group\_id) | ID of the security group for the worker nodes. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
