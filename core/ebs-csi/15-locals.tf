locals {
  # Tags
  tags = merge({
    terraform_module = "git@github.com:powise/terraform-modules//k8s/core/ebs-csi"
  }, var.tags)

  name = "ebs-csi-controller-sa"
}
