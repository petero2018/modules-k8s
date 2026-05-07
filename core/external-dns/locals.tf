locals {
  tags = merge({
    terraform_module = "git@github.com:powise/terraform-modules//k8s/core/external-dns"
  }, var.tags)
}
