resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.monitoring_namespace
  }
}


# --- Define complex variables for templates ---
locals {
  loki_service_url       = "http://loki-gateway.${var.monitoring_namespace}.svc.cluster.local:80"
  prometheus_service_url = "http://kube-prometheus-stack-prometheus.${var.monitoring_namespace}.svc.cluster.local:9090"
  # tempo_service_url       = "http://your-tempo-distributor.${var.monitoring_namespace}.svc.cluster.local:3200"

  # Grafana variables
  grafana_persistence_size = "10Gi"
  grafana_safe_domain      = "monitoring.${var.app_subdomain}"

}

# --- Kube Prometheus Stack ---
resource "helm_release" "kube_prometheus_stack" {
  name             = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = var.kube_prometheus_stack_helm_version
  namespace        = var.monitoring_namespace
  create_namespace = false
  timeout          = 900
  atomic           = true
  cleanup_on_fail  = true
  lint             = true

  values = [templatefile("${path.module}/templates/kube-prometheus-stack-values.yaml.tpl", {
    prometheus_retention               = "15d"
    prometheus_storage_size            = "50Gi"
    grafana_github_oauth_client_id     = var.grafana_github_oauth_client_id
    grafana_github_oauth_client_secret = var.grafana_github_oauth_client_secret
  })]

}


# --- Loki Stack ---
resource "helm_release" "loki" {
  name             = "loki"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "loki"
  version          = var.loki_helm_version
  namespace        = var.monitoring_namespace
  create_namespace = false
  timeout          = 600
  atomic           = true
  cleanup_on_fail  = true
  lint             = true

  values = [templatefile("${path.module}/templates/loki-values.yaml.tpl", {
    loki_replicas         = "1"
    loki_s3_bucket_chunks = "loki-chunks"
    loki_s3_bucket_ruler  = "loki-ruler"
    loki_s3_bucket_admin  = "loki-admin"
    loki_s3_endpoint      = var.loki_s3_endpoint_url
    loki_s3_region        = var.loki_s3_region
    loki_retention_period = var.loki_retention_period
    loki_s3_access_key    = var.loki_s3_access_key
    loki_s3_secret_key    = var.loki_s3_secret_key
  })]

}

# --- Vector ---
resource "helm_release" "vector" {
  name             = "vector"
  repository       = "https://helm.vector.dev"
  chart            = "vector"
  version          = var.vector_helm_version
  namespace        = var.monitoring_namespace
  create_namespace = false
  timeout          = 600
  atomic           = true
  cleanup_on_fail  = true
  lint             = true

  values = [templatefile("${path.module}/templates/vector-values.yaml.tpl", {
    maxmind_secret_key = var.maxmind_licence_key
  })]

  depends_on = [
    helm_release.loki,
    # kubernetes_secret.maxmind_secret # If managing secret in TF
  ]
}

