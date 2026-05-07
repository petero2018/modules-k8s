locals {

  name = "velero-server"

  template_file = var.template_file != "" ? var.template_file : "${path.module}/templates/velero.yaml"

  values = [templatefile(local.template_file, merge(var.template_values, {
    iam_role   = module.irsa.irsa_iam_role_arn
    aws_region = var.aws_region
    features   = join(",", var.features)
  }))]

  # Tags
  tags = merge({
    terraform_module = "git@github.com:powise/terraform-modules//k8s/velero"
  }, var.tags)
}
