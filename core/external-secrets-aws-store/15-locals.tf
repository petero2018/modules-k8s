locals {
  service_account = coalesce(var.service_account, "${var.name}-sa")
}
