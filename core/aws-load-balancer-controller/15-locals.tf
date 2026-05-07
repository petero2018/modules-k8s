locals {
  # Tags
  tags = merge({
    terraform_module = "git@github.com:powise/terraform-modules//k8s/core/aws-load-balancer-controller"
  }, var.tags)
  # Release
  name = "aws-load-balancer-controller"
}
