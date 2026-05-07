# argocd-cluster

This module defines an [external ArgoCD cluster][argocd-docs].

## Usage

This module requires a [pre-existing ArgoCD installation][argocd-module-link] which is running in cluster that must support IRSA, as it requires that the components of the ArgoCD install are able to assume the role created by this module in the target account. `argocd-server` and `argocd-application-controller` must be able to assume the role specified in [auth\_iam\_role\_arn](#input\_auth\_iam\_role\_arn). For flexibility this module does not create that role and only creates the role that will be assumed in the target account.

As well as the target role, ArgoCD must have permissions in the destination cluster's `aws-auth` configmap with CRUD permissions. For example:

```bash
$ k get configmap -n kube-system aws-auth -o yaml # in the destination cluster
apiVersion: v1
data:
  mapRoles: |
    ...
    - groups:
      - system:masters
      username: argocdsecurity
      rolearn: arn:aws:iam::482143490269:role/argocd-ClusterRole-sandbox-general
...
```

[argocd-docs]: https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/#clusters
[argocd-module-link]: ../argocd/README.md

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=3.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=3.0 |
| <a name="provider_aws.remote"></a> [aws.remote](#provider\_aws.remote) | >=3.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.argocd_remote_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [kubernetes_secret.cluster](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [aws_eks_cluster.remote](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_policy_document.argocd_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth_iam_role_arn"></a> [auth\_iam\_role\_arn](#input\_auth\_iam\_role\_arn) | The ARN of the role used to authenticate against the remote cluster. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Remote cluster name. | `string` | n/a | yes |
| <a name="input_create_suffixed_role"></a> [create\_suffixed\_role](#input\_create\_suffixed\_role) | If true, the remote role will be suffixed with the destination cluster name. This can be used to create separate roles when multiple clusters exist within a single account. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment (`dev`, `prod` or `tools`) of the remote cluster. Will be added as label to the cluster secret. | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of extra labels that will be applied to the cluster secret. | `map(string)` | `{}` | no |
| <a name="input_manage_cluster_resources"></a> [manage\_cluster\_resources](#input\_manage\_cluster\_resources) | Whether Argo CD can manage cluster-level resources on this cluster. This setting is used only if the list of managed namespaces is not empty. | `bool` | `false` | no |
| <a name="input_managed_namespaces"></a> [managed\_namespaces](#input\_managed\_namespaces) | A list of namespaces that ArgoCD is permitted to manage. | `list(string)` | `[]` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace where ArgoCD is installed. | `string` | `"argocd"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to AWS resources. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_argocd_security_role_arn"></a> [argocd\_security\_role\_arn](#output\_argocd\_security\_role\_arn) | The ARN of the IAM role created by the module. |
| <a name="output_argocd_security_role_name"></a> [argocd\_security\_role\_name](#output\_argocd\_security\_role\_name) | The name of the IAM role created by the module. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
