# Flower

Flower is an open-source web application for monitoring and managing Celery clusters. It provides real-time information about the status of Celery workers and tasks. More information about it can be found here: [flower.readthedocs.io](https://flower.readthedocs.io/en/latest/)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.13.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.13.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.7.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_flower_pod_security_policy"></a> [flower\_pod\_security\_policy](#module\_flower\_pod\_security\_policy) | git@github.com:powise/terraform-modules//k8s/core/security-group-policy | security-group-policy-1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.flower_pods](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.eks_worker_ingress_from_flower_pods](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.flower_pods_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.flower_pods_ingress_from_eks_worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.redis_ingress_from_flower_pods](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.videoask_flower_oauth2_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.videoask_flower_oauth2_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [kubectl_manifest.flower_destination_rule](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.flower_virtual_service](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_config_map.flower](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_deployment.flower](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_secret.flower](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_service.flower](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deploy_arch"></a> [deploy\_arch](#input\_deploy\_arch) | Node architecture to deploy to. Must be either "amd64" or "arm64" | `string` | `"arm64"` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | EKS cluster flower will be deployed to. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment flower will be deploy to. | `string` | n/a | yes |
| <a name="input_flower_container_http_port"></a> [flower\_container\_http\_port](#input\_flower\_container\_http\_port) | HTTP port for flower service. | `number` | `5555` | no |
| <a name="input_flower_docker_image_version"></a> [flower\_docker\_image\_version](#input\_flower\_docker\_image\_version) | Version of the Flower docker image to deploy. | `string` | `"98de8caab2a671837c3b65cdecb13e46b15980f8"` | no |
| <a name="input_flower_docker_repository_url"></a> [flower\_docker\_repository\_url](#input\_flower\_docker\_repository\_url) | Flower Docker repo to use. | `string` | `"mher/flower"` | no |
| <a name="input_flower_healthcheck_path"></a> [flower\_healthcheck\_path](#input\_flower\_healthcheck\_path) | URI for flower deployment healthcheck. | `string` | `"/healthcheck"` | no |
| <a name="input_flower_oauth2_key"></a> [flower\_oauth2\_key](#input\_flower\_oauth2\_key) | OAuth2 key for flower. | `string` | n/a | yes |
| <a name="input_flower_oauth2_secret"></a> [flower\_oauth2\_secret](#input\_flower\_oauth2\_secret) | OAuth2 secret for flower. | `string` | n/a | yes |
| <a name="input_flower_route53_record"></a> [flower\_route53\_record](#input\_flower\_route53\_record) | Route53 record for flower. | `string` | n/a | yes |
| <a name="input_flower_service_name"></a> [flower\_service\_name](#input\_flower\_service\_name) | Name of deployed service. | `string` | `"flower-celery"` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMS Key to ise to encrypt SSM parameters. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to deploy flower to. | `string` | n/a | yes |
| <a name="input_read_only_root_filesystem"></a> [read\_only\_root\_filesystem](#input\_read\_only\_root\_filesystem) | Whether to set root filesystem to ReadOnly. | `bool` | `true` | no |
| <a name="input_redis_address"></a> [redis\_address](#input\_redis\_address) | Address for Redis instance used for Celery Broker URL. | `string` | n/a | yes |
| <a name="input_redis_security_group_id"></a> [redis\_security\_group\_id](#input\_redis\_security\_group\_id) | Security group id for Redis to allow access from flower pods. | `string` | n/a | yes |
| <a name="input_restricted_ingress_gateway_name"></a> [restricted\_ingress\_gateway\_name](#input\_restricted\_ingress\_gateway\_name) | Name of the restricted ingress gateway | `string` | n/a | yes |
| <a name="input_restricted_ingress_gateway_namespace"></a> [restricted\_ingress\_gateway\_namespace](#input\_restricted\_ingress\_gateway\_namespace) | Namespace of the restricted ingress gateway. | `string` | n/a | yes |
| <a name="input_run_as_non_root"></a> [run\_as\_non\_root](#input\_run\_as\_non\_root) | Needs to be true in order to run the container as a non-root user | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to resources. | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID to deploy security group to. | `string` | n/a | yes |
| <a name="input_workers_security_group_id"></a> [workers\_security\_group\_id](#input\_workers\_security\_group\_id) | Security group id for EKS workers. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
