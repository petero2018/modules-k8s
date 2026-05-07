# ArgoCD

Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes.

Application definitions, configurations, and environments should be declarative and version controlled. Application deployment and lifecycle management should be automated, auditable, and easy to understand.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~>3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | ~>3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_release"></a> [release](#module\_release) | ../helm-release | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.encrypted_admin_password](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | admin password. | `string` | n/a | yes |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The version of argocd to install. | `string` | n/a | yes |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. | `bool` | `false` | no |
| <a name="input_data_permissions"></a> [data\_permissions](#input\_data\_permissions) | Permissions for DATA Teams | `string` | `"      p, role:data, applications, get, */*, allow\n      p, role:data, certificates, get, *, allow\n      p, role:data, clusters, get, *, allow\n      p, role:data, repositories, get, *, allow\n      p, role:data, projects, get, *, allow\n      p, role:data, accounts, get, *, allow\n      p, role:data, gpgkeys, get, *, allow\n      p, role:data, applications, update, */*, allow\n      p, role:data, applications, sync, */*, allow\n      p, role:data, applications, override, */*, allow\n      p, role:data, applications, action/*, */*, allow\n      p, role:data, applications, delete, */*, allow\n      g, argocd-data, role:data\n"` | no |
| <a name="input_enable_ingress"></a> [enable\_ingress](#input\_enable\_ingress) | Enables ArgoCD ingress. | `bool` | `false` | no |
| <a name="input_helm_set_values"></a> [helm\_set\_values](#input\_helm\_set\_values) | Value blocks to be merged with the values YAML and passed to the helm module | `map(string)` | `{}` | no |
| <a name="input_helm_values"></a> [helm\_values](#input\_helm\_values) | List of values in raw yaml to pass to the helm module. | `list(string)` | `[]` | no |
| <a name="input_ingress_class"></a> [ingress\_class](#input\_ingress\_class) | Ingress class to use. | `string` | `""` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the components in. | `string` | `"kube-system"` | no |
| <a name="input_okta_admin"></a> [okta\_admin](#input\_okta\_admin) | OKTA Group to assign admin permissions on ArgoCD. | `string` | `"admins"` | no |
| <a name="input_okta_ca_base64"></a> [okta\_ca\_base64](#input\_okta\_ca\_base64) | OKTA CA in base64. | `string` | `""` | no |
| <a name="input_okta_enable"></a> [okta\_enable](#input\_okta\_enable) | Flag to enable or disable OKTA integration. | `bool` | `false` | no |
| <a name="input_okta_groups"></a> [okta\_groups](#input\_okta\_groups) | OKTA Group to assign ArgoCD roles. | `map(string)` | <pre>{<br>  "Developers": "dev"<br>}</pre> | no |
| <a name="input_okta_sso_domain"></a> [okta\_sso\_domain](#input\_okta\_sso\_domain) | OKTA SSO domain. | `string` | `""` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | Permissions roles to apply | <pre>map(list(object({<br>    resource = string<br>    action   = string<br>    object   = string<br>  })))</pre> | <pre>{<br>  "dev": [<br>    {<br>      "action": "get",<br>      "object": "*",<br>      "resource": "clusters"<br>    },<br>    {<br>      "action": "get",<br>      "object": "*",<br>      "resource": "repositories"<br>    }<br>  ]<br>}</pre> | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for release installation. | `number` | `1200` | no |
| <a name="input_ui_domain"></a> [ui\_domain](#input\_ui\_domain) | Domain to use for ArgoCD. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
