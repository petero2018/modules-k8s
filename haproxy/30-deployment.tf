resource "kubernetes_deployment" "haproxy" {
  #checkov:skip=CKV_K8S_28:Not needed
  #checkov:skip=CKV_K8S_29:Not needed
  #checkov:skip=CKV_K8S_30:Not needed
  metadata {
    name      = var.name
    namespace = var.namespace

    labels = local.labels
  }

  spec {
    replicas = var.replicas

    strategy {
      type = "RollingUpdate"

      rolling_update {
        max_unavailable = 0
        max_surge       = 2
      }
    }

    selector {
      match_labels = {
        app = var.name
      }
    }

    template {
      metadata {
        labels = local.labels

        annotations = {
          "config-checksum" = sha256(join("|", values(kubernetes_config_map.haproxy_config.data)))
        }
      }

      spec {
        volume {
          name = "config"
          config_map {
            name = kubernetes_config_map.haproxy_config.metadata[0].name
          }
        }

        termination_grace_period_seconds = 300

        container {
          image = var.image
          name  = "haproxy"

          command = ["haproxy"]
          args    = ["-f", "/config/haproxy.cfg"]

          resources {
            requests = {
              cpu    = var.requests.cpu
              memory = var.requests.memory
            }

            limits = {
              cpu    = var.limits.cpu
              memory = var.limits.memory
            }
          }

          readiness_probe {
            http_get {
              path = "/stats"
              port = 8000
            }

            initial_delay_seconds = 5
            period_seconds        = 5
          }

          liveness_probe {
            http_get {
              path = "/stats"
              port = 8000
            }

            initial_delay_seconds = 10
            period_seconds        = 5
          }

          lifecycle {
            pre_stop {
              exec {
                command = ["/bin/sleep", "240"]
              }
            }
          }

          volume_mount {
            name       = "config"
            mount_path = "/config"
            read_only  = true
          }
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [spec[0].replicas]
  }

  timeouts {
    create = var.timeouts.create
    update = var.timeouts.update
    delete = var.timeouts.delete
  }
}
