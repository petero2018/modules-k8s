locals {
  labels = merge({
    "app.kubernetes.io/component" : "terraform-modules.k8s.core.rbac",
    "app.kubernetes.io/managed-by" : "terraform"
  }, var.labels)

  annotations = merge({
    terraform_module = "git@github.com:powise/terraform-modules//k8s/core/rbac"
  }, var.annotations)
}
