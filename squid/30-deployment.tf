resource "kubernetes_deployment" "squid" {
  #checkov:skip=CKV_K8S_28:Not needed
  #checkov:skip=CKV_K8S_29:YAGNI here
  #checkov:skip=CKV_K8S_30:Not needed
  #checkov:skip=CKV_K8S_11:"CPU Limits are set via vars"
  #checkov:skip=CKV_K8S_12:"Memory Limits are set via vars"
  #checkov:skip=CKV_K8S_37:"Restriction of capabilities are set via vars"
  #checkov:skip=CKV_K8S_22:"A RO FS results in the following error: FATAL: failed to open /run/squid.pid: (30) Read-only file system"
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
          "config-checksum" = sha256(join("|", values(kubernetes_config_map.squid_config.data)))
        }
      }

      spec {
        volume {
          name = "config"
          config_map {
            name = kubernetes_config_map.squid_config.metadata[0].name
          }
        }

        security_context {
          fs_group = var.pod_security_context.fs_group
        }

        termination_grace_period_seconds = 30

        node_selector = {
          "kubernetes.io/arch" : var.deploy_arch
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
          image             = var.image
          name              = "squid"
          image_pull_policy = "Always"

          security_context {
            run_as_non_root = var.run_as_non_root
            run_as_group    = var.run_as_group # ISSUE: https://github.com/hashicorp/terraform-provider-kubernetes/issues/695
            run_as_user     = var.run_as_user
            capabilities {
              add  = var.container_security_context.add_capabilities
              drop = var.container_security_context.drop_capabilities
            }
          }

          resources {
            requests = {
              cpu    = var.requests.cpu
              memory = var.requests.memory
            }
          }

          readiness_probe {
            tcp_socket {
              port = 3128
            }

            initial_delay_seconds = 5
            period_seconds        = 5
          }

          liveness_probe {
            tcp_socket {
              port = 3128
            }

            initial_delay_seconds = 10
            period_seconds        = 5
          }

          volume_mount {
            name       = "config"
            mount_path = "/etc/squid/"
            read_only  = true
          }
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [spec[0].replicas]
  }
}
