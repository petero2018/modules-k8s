# AWS Node Termination Handler

The `aws-node-termination-handler` Instance Metadata Service Monitor will run a small pod on each host to perform monitoring of IMDS paths like /spot or /events and react accordingly to drain and/or cordon the corresponding node.
the workflow can be summarized as:
- Identify that a Spot Instance is being reclaimed.
- Use the 2-minute notification window to gracefully prepare the node for termination.
- Taint the node and cordon it off to prevent new pods from being placed.
- Drain connections on the running pods.
- Replace the pods on remaining nodes to maintain the desired capacity.

`Queue Processor` is not supported by this module.

## Docs
https://ec2spotworkshops.com/using_ec2_spot_instances_with_eks/070_selfmanagednodegroupswithspot/deployhandler.html
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
| <a name="module_release"></a> [release](#module\_release) | ../../helm-release | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_app_config"></a> [argocd\_app\_config](#input\_argocd\_app\_config) | ArgoCD Application config. See k8s/argocd/resources/application | `any` | `{}` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The version of node termination handler to install. | `string` | n/a | yes |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. | `bool` | `false` | no |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for node termination handler | `any` | `{}` | no |
| <a name="input_manage_via_argocd"></a> [manage\_via\_argocd](#input\_manage\_via\_argocd) | Determines if the release should be managed via ArgoCD. | `bool` | `false` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the components in. | `string` | `"kube-system"` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for release installation. | `number` | `300` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
