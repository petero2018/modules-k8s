module "flower_pod_security_policy" {
  source             = "git@github.com:powise/terraform-modules//k8s/core/security-group-policy?ref=security-group-policy-1.0.0"
  name               = "flower-celery"
  namespace          = var.namespace
  selector           = "podSelector"
  match_labels       = { app = "flower-celery" }
  match_expressions  = []
  security_group_ids = [aws_security_group.flower_pods.id]
}
