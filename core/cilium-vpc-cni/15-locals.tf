locals {
  # Tags
  tags = merge({
    terraform_module = "git@github.com:powise/terraform-modules//k8s/core/cilium-vpc-cni"
  }, var.tags)
}
