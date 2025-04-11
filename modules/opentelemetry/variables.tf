# modules/opentelemetry/variables.tf

variable "otel_namespace" {
  description = "Kubernetes namespace for OpenTelemetry components"
  type        = string
}

variable "otel_collector_helm_version" {
  description = "Helm chart version for OpenTelemetry Collector"
  type        = string
}

variable "tempo_helm_version" {
  description = "Helm chart version for Tempo"
  type        = string
}

variable "tempo_bucket_name" {
  description = "S3 bucket name for Tempo storage"
  type        = string
}

variable "tempo_s3_endpoint_url" {
  description = "S3 endpoint URL for Tempo storage"
  type        = string
}

variable "tempo_s3_region" {
  description = "S3 region for Tempo storage"
  type        = string
}

variable "tempo_s3_access_key" {
  description = "S3 access key for Tempo storage"
  type        = string
  sensitive   = true
}

variable "tempo_s3_secret_key" {
  description = "S3 secret key for Tempo storage"
  type        = string
  sensitive   = true
}
