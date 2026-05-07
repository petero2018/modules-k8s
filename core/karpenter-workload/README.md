# karpenter-workload

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.29.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.29.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.default_nodeclass](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.default_nodeclass_auto_mode](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.default_nodepool](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.default_nodepool_auto_mode](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_ssm_parameter.amd_ami_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.arm_ami_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_auto_mode"></a> [eks\_auto\_mode](#input\_eks\_auto\_mode) | Use EKS Auto Mode CRDs instead of default Karpenter ones. | `bool` | `false` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster to deploy into. | `string` | n/a | yes |
| <a name="input_karpenter_config"></a> [karpenter\_config](#input\_karpenter\_config) | Karpenter worload configuration. | <pre>map(object({<br>    vpc_name = optional(string, "eks") # Used in EKS Auto Mode to target the proper subnets<br>    block_device_mappings = optional(list(object({<br>      deviceName = optional(string, "/dev/xvda")<br>      ebs = optional(object({<br>        volumeSize          = optional(string, "100Gi")<br>        volumeType          = optional(string, "gp3")<br>        iops                = optional(number, 3000)<br>        throughput          = optional(number, 125)<br>        encrypted           = optional(bool, true)<br>        key                 = optional(string, "")<br>        deleteOnTermination = optional(bool, true)<br>      }))<br>    })))<br>    extra_security_groups_selectors = optional(list(object({ tags = map(string) })), [])<br>    nodepool_config = optional(object({<br>      architecture         = optional(list(string), ["arm64", "amd64"])<br>      os                   = optional(list(string), ["linux"])<br>      instance_family      = optional(list(string), ["c7g", "m5", "m7g"])<br>      instance_cpu         = optional(list(string), ["4", "8", "16"])<br>      instance_generation  = optional(list(string), ["2"])<br>      capacity_type        = optional(list(string), ["on-demand"])<br>      consolidation_policy = optional(string, "WhenEmptyOrUnderutilized")<br>      consolidation_period = optional(string, "30s")<br>      expire_after         = optional(string, "720h")<br>      limits = optional(object({<br>        cpu    = optional(string, "50")<br>        memory = optional(string, "50Gi")<br>      }))<br>      labels = optional(map(string), {})<br>      taints = optional(list(object({<br>        key    = string,<br>        value  = string,<br>        effect = string<br>      })), null)<br>      node_disruption_budgets = optional(list(object({<br>        nodes    = optional(string, "10%")<br>        schedule = optional(string)<br>        duration = optional(string)<br>        reasons  = optional(list(string))<br>      })))<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to AWS resources. | `map(string)` | n/a | yes |
| <a name="input_worker_role_name"></a> [worker\_role\_name](#input\_worker\_role\_name) | IAM role name to use for the node identity. The "role" field is immutable after EC2NodeClass creation. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
