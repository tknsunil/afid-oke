# modules/monitoring/variables.tf
variable "loki_helm_version" {
  description = "Helm chart version for Loki"
  type        = string
  default     = "6.29.0"
}

variable "vector_helm_version" {
  description = "Helm chart version for Vector"
  type        = string
  default     = "0.42.0"
}

variable "kube_prometheus_stack_helm_version" {
  description = "Helm chart version for Kube Prometheus Stack"
  type        = string
  default     = "70.4.2"
}


variable "monitoring_namespace" {
  description = "Kubernetes namespace for monitoring components"
  type        = string
  default     = "monitoring"
}

variable "app_subdomain" {
  description = "Subdomain"
  type        = string
}

variable "loki_s3_endpoint_url" {
  description = "S3 endpoint URL for Loki storage"
  type        = string
}

variable "loki_s3_region" {
  description = "S3 region for Loki storage"
  type        = string
}

variable "loki_bucket_name" {
  description = "S3 bucket name for Loki storage"
  type        = string
}

variable "loki_s3_access_key" {
  description = "S3 access key for Loki storage"
  type        = string
  sensitive   = true
}

variable "loki_s3_secret_key" {
  description = "S3 secret key for Loki storage"
  type        = string
  sensitive   = true
}

variable "loki_retention_period" {
  description = "Retention period for Loki logs"
  type        = string
  default     = "15d"

}

variable "grafana_admin_password" {
  description = "Admin password for Grafana"
  type        = string
  sensitive   = true
  default     = "admin"
}

variable "grafana_github_oauth_client_id" {
  type = string
}

variable "grafana_github_oauth_client_secret" {
  type      = string
  sensitive = true
}

variable "maxmind_licence_key" {
  type      = string
  sensitive = true
}
