locals {
  name = "karpenter"
  # Tags
  tags = merge({
    terraform_module = "git@github.com:powise/terraform-modules//k8s/core/karpenter"
  }, var.tags)
}
