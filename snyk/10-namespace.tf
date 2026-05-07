module "namespace" {
  source = "../core/namespace"

  name         = local.name
  enable_istio = var.enable_istio

  rbac_groups          = []
  rbac_users           = []
  rbac_groups_readonly = false
  rbac_users_readonly  = false
}
