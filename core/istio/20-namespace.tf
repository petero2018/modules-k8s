module "namespace" {
  source = "git@github.com:powise/terraform-modules//k8s/core/namespace?ref=core-namespace-2.2.3"

  name         = "istio-system"
  enable_istio = false

  rbac_users          = ["developers"]
  rbac_users_readonly = true

  rbac_groups          = []
  rbac_groups_readonly = true
}
