locals {
  labels = {
    "app"       = var.name
    "log-index" = "haproxy" # We log HAProxy logs to a different index as they have a high volume
  }
}
