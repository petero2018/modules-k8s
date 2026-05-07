resource "kubernetes_deployment" "flower" {
  metadata {
    name = var.flower_service_name
    labels = {
      app = var.flower_service_name
    }
    namespace = var.namespace
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = var.flower_service_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.flower_service_name
        }
      }

      spec {
        node_selector = {
          "kubernetes.io/arch" : var.deploy_arch
        }

        toleration {
          key      = "architecture"
          effect   = "NoExecute"
          operator = "Equal"
          value    = var.deploy_arch
        }

        affinity {
          pod_anti_affinity {
            preferred_during_scheduling_ignored_during_execution {
              pod_affinity_term {
                label_selector {
                  match_labels = {
                    app = var.flower_service_name
                  }
                }
                topology_key = "topology.kubernetes.io/zone"
              }
              weight = 100
            }
          }
        }

        container {
          image = "${var.flower_docker_repository_url}:${var.flower_docker_image_version}"
          name  = var.flower_service_name

          readiness_probe {
            http_get {
              path = var.flower_healthcheck_path
              port = var.flower_container_http_port
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }

          liveness_probe {
            http_get {
              path = var.flower_healthcheck_path
              port = var.flower_container_http_port
            }
          }

          security_context {
            run_as_non_root           = var.run_as_non_root
            read_only_root_filesystem = var.read_only_root_filesystem
            capabilities {
              drop = [
                "ALL",
                "NET_RAW"
              ]
            }
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.flower.metadata[0].name
            }
          }
          env_from {
            secret_ref {
              name = kubernetes_secret.flower.metadata[0].name
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "flower" {
  metadata {
    name      = var.flower_service_name
    namespace = var.namespace
  }
  spec {
    selector = {
      app = var.flower_service_name
    }
    port {
      port        = 80
      target_port = var.flower_container_http_port
    }

    type = "ClusterIP"
  }
}

resource "kubectl_manifest" "flower_virtual_service" {
  yaml_body = templatefile(
    "${path.module}/templates/virtual_service.yaml.tftpl",
    {
      namespace         = var.namespace
      hostnames         = [var.flower_route53_record]
      name              = var.flower_service_name
      gateway_namespace = var.restricted_ingress_gateway_namespace
      gateway_name      = var.restricted_ingress_gateway_name
    }
  )
}

resource "kubectl_manifest" "flower_destination_rule" {
  yaml_body = templatefile(
    "${path.module}/templates/destination_rule.yaml.tftpl",
    {
      namespace = var.namespace
      name      = var.flower_service_name
    }
  )
}

resource "kubernetes_config_map" "flower" {
  metadata {
    name      = var.flower_service_name
    namespace = var.namespace
  }

  data = {
    CELERY_BROKER_URL           = "redis://${var.redis_address}:6379/0"
    FLOWER_AUTH_PROVIDER        = "flower.views.auth.OktaLoginHandler"
    FLOWER_AUTH                 = ".*@powise\\.com"
    FLOWER_OAUTH2_REDIRECT_URI  = "https://${var.flower_route53_record}/login"
    FLOWER_OAUTH2_OKTA_BASE_URL = "https://tf.okta.com/oauth2"
  }
}

resource "kubernetes_secret" "flower" {
  metadata {
    name      = var.flower_service_name
    namespace = var.namespace
  }

  data = {
    FLOWER_OAUTH2_KEY    = aws_ssm_parameter.videoask_flower_oauth2_key.value
    FLOWER_OAUTH2_SECRET = aws_ssm_parameter.videoask_flower_oauth2_secret.value
  }
}
