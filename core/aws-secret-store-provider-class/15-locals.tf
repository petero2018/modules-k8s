locals {
  # Segregate by type
  objects_by_type = {
    for obj in var.objects : obj.type => obj...
  }
  # SSM Parameters
  ssm_parameters = lookup(local.objects_by_type, "ssmparameter", [])
  # AWS Secrets
  aws_secrets = lookup(local.objects_by_type, "secretsmanager", [])
}
