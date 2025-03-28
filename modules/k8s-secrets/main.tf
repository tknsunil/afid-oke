resource "kubernetes_secret" "django_s3_secrets" {
  lifecycle {
    ignore_changes = [metadata]
  }
  metadata {
    name      = "django-s3-secrets"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"

  data = {
    access-key   = var.django_s3_access_key
    secret-key   = var.django_s3_secret_key
    endpoint-url = var.django_s3_endpoint_url
    region       = var.django_s3_region != "" ? var.django_s3_region : ""
  }
}

resource "kubernetes_secret" "loki_s3_secrets" {
  lifecycle {
    ignore_changes = [metadata]
  }
  metadata {
    name      = "loki-s3-secrets"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"

  data = {
    access-key   = var.loki_s3_access_key
    secret-key   = var.loki_s3_secret_key
    endpoint-url = var.loki_s3_endpoint_url
    region       = var.loki_s3_region != "" ? var.loki_s3_region : ""
  }
}

resource "kubernetes_secret" "tempo_s3_secrets" {
  lifecycle {
    ignore_changes = [metadata]
  }
  metadata {
    name      = "tempo-s3-secrets"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"

  data = {
    access-key   = var.tempo_s3_access_key
    secret-key   = var.tempo_s3_secret_key
    endpoint-url = var.tempo_s3_endpoint_url
    region       = var.tempo_s3_region != "" ? var.tempo_s3_region : ""
  }
}
