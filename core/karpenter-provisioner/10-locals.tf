locals {
  # Tags
  tags = merge({
    terraform_module = "git@github.com:powise/terraform-modules//k8s/core/karpenter-provisioner"
  }, var.tags)
  # Annotations
  annotations = merge({
    terraform_module = "git@github.com:powise/terraform-modules//k8s/core/karpenter-provisioner"
  }, var.annotations)
}
