resource "kubernetes_deployment" "haproxy" {
  #checkov:skip=CKV_K8S_28:Not needed
  #checkov:skip=CKV_K8S_29:YAGNI here
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
          "secret-checksum" = sha256(join("|", values(kubernetes_secret.haproxy.data)))
          "ad.datadoghq.com/haproxy.checks" = jsonencode({
            openmetrics = {
              init_config = {},
              instances = [
                {
                  "openmetrics_endpoint" = "http://%%host%%:8405/metrics",
                  "namespace"            = "haproxy",
                  "metrics"              = [".*"]
                }
              ]
            }
          })
        }
      }

      spec {
        volume {
          name = "config"
          config_map {
            name = kubernetes_config_map.haproxy_config.metadata[0].name
          }
        }

        volume {
          name = "tls"
          secret {
            secret_name  = kubernetes_secret.haproxy.metadata[0].name
            default_mode = "0644"
          }
        }

        termination_grace_period_seconds = 300

        node_selector = {
          "kubernetes.io/arch" = var.deploy_arch
        }

        dynamic "toleration" {
          for_each = local.tolerations
          content {
            key      = toleration.value.key
            operator = toleration.value.operator
            value    = toleration.value.value
            effect   = toleration.value.effect
          }
        }

        container {
          image = "567716553783.dkr.ecr.us-east-1.amazonaws.com/mirror/haproxy:2.4.3"
          name  = "haproxy"

          command = ["haproxy"]
          args    = ["-f", "/config/haproxy.cfg"]

          resources {
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }

            limits = {
              cpu    = "1000m"
              memory = "1024Mi"
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

          volume_mount {
            name       = "tls"
            mount_path = "/tls"
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
