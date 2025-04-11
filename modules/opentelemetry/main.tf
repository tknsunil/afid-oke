# modules/opentelemetry/main.tf

# Tempo for distributed tracing
resource "helm_release" "tempo" {
  name             = "tempo"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "tempo"
  version          = var.tempo_helm_version
  namespace        = var.otel_namespace
  create_namespace = false
  timeout          = 600
  atomic           = true
  cleanup_on_fail  = true
  lint             = true

  values = [templatefile("${path.module}/templates/tempo.yaml.tpl", {
    bucket_name = var.tempo_bucket_name
    endpoint    = var.tempo_s3_endpoint_url
    region      = var.tempo_s3_region
    access_key  = var.tempo_s3_access_key
    secret_key  = var.tempo_s3_secret_key
  })]
}

# OpenTelemetry Collector
resource "helm_release" "opentelemetry_collector" {
  count            = 0
  name             = "opentelemetry-collector"
  repository       = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart            = "opentelemetry-collector"
  version          = var.otel_collector_helm_version
  namespace        = var.otel_namespace
  create_namespace = false
  timeout          = 600
  atomic           = true
  cleanup_on_fail  = true
  lint             = true

  values = [templatefile("${path.module}/templates/opentelemetry.yaml.tpl", {})]

  depends_on = [
    helm_release.tempo
  ]
}
