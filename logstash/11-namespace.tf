module "namespace" {
  count = var.create_namespace ? 1 : 0

  source = "git@github.com:powise/terraform-modules//k8s/core/namespace?ref=core-namespace-2.1.0"

  name         = var.namespace
  enable_istio = var.enable_istio

  rbac_groups          = []
  rbac_users           = []
  rbac_users_readonly  = true
  rbac_groups_readonly = true
}
