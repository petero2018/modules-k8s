# gatekeeper

This module deploys and configures gatekeeper on a kubernetes cluster.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.13 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gatekeeper_release"></a> [gatekeeper\_release](#module\_gatekeeper\_release) | git@github.com:powise/terraform-modules//k8s/helm-release | helm-release-0.3.1 |

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.gatekeeper_config](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_audit_interval"></a> [audit\_interval](#input\_audit\_interval) | Specifies how often the audit service runs on the cluster. This should be tailored per-cluster so that audit runs do not overlap or cause excessive output. | `string` | `60` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The version of gatekeeper chart to install. | `string` | `"3.10.0"` | no |
| <a name="input_config_match_data"></a> [config\_match\_data](#input\_config\_match\_data) | A list of namespace(s)/proccess(es) objects which will be excluded from Gatekeeper's actions at a cluster-level. | <pre>list(object({<br>    excludedNamespaces = list(string)<br>    processes          = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_config_sync_data"></a> [config\_sync\_data](#input\_config\_sync\_data) | A list of kubernetes resources that will be synced into Gatekeeper's cache, for the purposes of enriching data available to rules. | <pre>list(object({<br>    group   = string,<br>    version = string,<br>    kind    = string<br>  }))</pre> | <pre>[<br>  {<br>    "group": "",<br>    "kind": "Namespace",<br>    "version": "v1"<br>  },<br>  {<br>    "group": "security.istio.io",<br>    "kind": "PeerAuthentication",<br>    "version": "v1beta1"<br>  },<br>  {<br>    "group": "security.istio.io",<br>    "kind": "AuthorizationPolicy",<br>    "version": "v1beta1"<br>  }<br>]</pre> | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Whether the namespace will be created by Helm. | `bool` | `true` | no |
| <a name="input_deploy_arch"></a> [deploy\_arch](#input\_deploy\_arch) | Node architecture to deploy to. Must be either "amd64" or "arm64" | `string` | `"arm64"` | no |
| <a name="input_helm_set_values"></a> [helm\_set\_values](#input\_helm\_set\_values) | Value blocks to be merged with the values YAML and passed to the helm module. | `map(string)` | `{}` | no |
| <a name="input_helm_values"></a> [helm\_values](#input\_helm\_values) | List of values in raw yaml to pass to the helm module. | `list(string)` | `[]` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace in which Gatekeeper will be installed. | `string` | `"gatekeeper-system"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
