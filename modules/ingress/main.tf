# modules/ingress/main.tf

# Nginx Ingress Controller
resource "helm_release" "nginx_ingress" {
  name             = "nginx-ingress"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = var.nginx_ingress_helm_version
  namespace        = var.ingress_namespace
  create_namespace = true
  timeout          = 600
  atomic           = true
  cleanup_on_fail  = true
  lint             = true

  values = [
    var.use_pre_created_lb ? templatefile("${path.module}/templates/values-with-lb.yaml.tpl", {
      load_balancer_id  = var.load_balancer_id
      enable_monitoring = var.enable_monitoring
      http_backend_set  = var.http_backend_set_name
      https_backend_set = var.https_backend_set_name
      }) : templatefile("${path.module}/templates/values-default.yaml.tpl", {
      enable_monitoring = var.enable_monitoring
      lb_min_bandwidth  = var.lb_min_bandwidth
      lb_max_bandwidth  = var.lb_max_bandwidth
    })
  ]


}

# Wait for the ingress controller to be ready
resource "time_sleep" "wait_for_ingress_controller" {
  depends_on      = [helm_release.nginx_ingress]
  create_duration = "30s"
}

# Get the load balancer IP address
data "kubernetes_service" "nginx_ingress" {
  depends_on = [time_sleep.wait_for_ingress_controller]
  metadata {
    name      = "nginx-ingress-ingress-nginx-controller"
    namespace = var.ingress_namespace
  }
}

# Create ingress resources for services
resource "kubernetes_ingress_v1" "grafana_ingress" {
  count = var.enable_monitoring ? 1 : 0

  metadata {
    name      = "grafana-ingress"
    namespace = var.monitoring_namespace
    annotations = {
      "kubernetes.io/ingress.class"    = "nginx"
      "cert-manager.io/cluster-issuer" = "letsencrypt-prod"
    }
  }

  spec {
    rule {
      host = "monitoring.${var.subdomain}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "kube-prometheus-stack-grafana"
              port {
                number = 80
              }
            }
          }
        }
      }
    }

    tls {
      hosts       = ["monitoring.${var.subdomain}"]
      secret_name = "grafana-tls"
    }
  }

  depends_on = [
    helm_release.nginx_ingress
  ]
}

resource "kubernetes_ingress_v1" "rabbitmq_ingress" {
  metadata {
    name      = "rabbitmq-ingress"
    namespace = var.rabbitmq_namespace
    annotations = {
      "kubernetes.io/ingress.class"    = "nginx"
      "cert-manager.io/cluster-issuer" = "letsencrypt-prod"
    }
  }

  spec {
    rule {
      host = "rabbitmq.${var.subdomain}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "rabbitmq"
              port {
                number = 15672
              }
            }
          }
        }
      }
    }

    tls {
      hosts       = ["rabbitmq.${var.subdomain}"]
      secret_name = "rabbitmq-tls"
    }
  }

  depends_on = [
    helm_release.nginx_ingress
  ]
}


resource "kubernetes_ingress_v1" "afid_ingress" {
  metadata {
    name      = "afid-ingress"
    namespace = "default"
    annotations = {
      "kubernetes.io/ingress.class"    = "nginx"
      "cert-manager.io/cluster-issuer" = "letsencrypt-prod"
    }
  }
  spec {
    rule {
      host = var.subdomain
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "afid-django"
              port {
                number = 8000
              }
            }
          }
        }
        path {
          path      = "/_next/"
          path_type = "Prefix"
          backend {
            service {
              name = "afid-nextjs"
              port {
                number = 3000
              }
            }
          }
        }
      }
    }

    tls {
      hosts       = [var.subdomain]
      secret_name = "afid-tls"
    }
  }

  depends_on = [
    helm_release.nginx_ingress
  ]
}
