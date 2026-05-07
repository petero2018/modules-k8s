resource "kubernetes_deployment" "caddy" {
  #checkov:skip=CKV_K8S_14:Image tag is fixed by a variable
  #checkov:skip=CKV_K8S_28:Might add later, not needed for now
  #checkov:skip=CKV_K8S_29:Might add later, not needed for now
  #checkov:skip=CKV_K8S_30:Might add later, not needed for now
  #checkov:skip=CKV_K8S_10:CPU requests are set through a variable
  #checkov:skip=CKV_K8S_11:CPU limits are set through a variable
  #checkov:skip=CKV_K8S_12:Memory limits are set through a variable
  #checkov:skip=CKV_K8S_13:Memory requests are set through a variable

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
        max_unavailable = 1
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
        labels = merge(local.labels, {
          "sidecar.istio.io/inject" = "true", # Force istio sidecar injection
        })
        annotations = {
          "sidecar.istio.io/interceptionMode"            = "TPROXY" # IP preservation, otherwise all client IPs appear as "127.0.0.6"
          "traffic.sidecar.istio.io/excludeInboundPorts" = "443,80"
          "ad.datadoghq.com/caddy.checks" = jsonencode(
            {
              "openmetrics" = {
                "init_config" = {},
                "instances" = [
                  {
                    "openmetrics_endpoint" = "http://%%host%%:9000/",
                    "namespace"            = "caddy",
                    "metrics" = [
                      { "caddy_http_requests_in_flight" = "http.requests.in_flight" },
                      { "caddy_http_requests" = "http.requests" },
                      { "promhttp_metric_handler_requests" = "prometheus.handler.requests" },
                      { "caddy_reverse_proxy_upstreams_healthy" = "reverse_proxy.upstreams.healthy" },
                      "caddy_http_request_duration_.*",
                      "caddy_http_response_duration_.*",
                    ]
                  }
                ]
              }
            }
          )
        }
      }

      spec {
        service_account_name = kubernetes_service_account.caddy.metadata[0].name

        volume {
          name = "config"
          config_map {
            name = kubernetes_config_map.caddy.metadata[0].name
          }
        }

        termination_grace_period_seconds = 370 # Pre-stop sleep time + 60s

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
          image = "${var.docker_image_repository}:${var.docker_image_tag}"
          name  = "caddy"

          command = ["caddy"]
          args    = ["run", "--config", "/etc/caddy/config/config.json"]

          resources {
            requests = var.resources_requests
            limits   = var.resources_limits
          }

          readiness_probe {
            http_get {
              path = "/"
              port = 8080
            }

            initial_delay_seconds = 5
            period_seconds        = 5
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 8080
            }

            initial_delay_seconds = 10
            period_seconds        = 5
          }

          lifecycle { # Helps with NLB deregistration delays
            pre_stop {
              exec {
                command = ["/bin/sleep", "310"] # NLB deregistration delay + 10s
              }
            }
          }

          volume_mount {
            name       = "config"
            mount_path = "/etc/caddy/config"
            read_only  = true
          }

        }
      }
    }
  }
}
