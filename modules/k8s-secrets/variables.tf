variable "django_s3_access_key" {
  type        = string
  description = "Access key for Django S3 secrets."
}

variable "django_s3_secret_key" {
  type        = string
  description = "Secret key for Django S3 secrets."
}

variable "django_s3_endpoint_url" {
  type        = string
  description = "Endpoint URL for Django S3 secrets."
}

variable "django_s3_region" {
  type        = string
  description = "(Optional) Region for Django S3 secrets."
  default     = ""
}

variable "loki_s3_access_key" {
  type        = string
  description = "Access key for Loki S3 secrets."
}

variable "loki_s3_secret_key" {
  type        = string
  description = "Secret key for Loki S3 secrets."
}

variable "loki_s3_endpoint_url" {
  type        = string
  description = "Endpoint URL for Loki S3 secrets."
}

variable "loki_s3_region" {
  type        = string
  description = "(Optional) Region for Loki S3 secrets."
  default     = ""
}

variable "tempo_s3_access_key" {
  type        = string
  description = "Access key for Tempo S3 secrets."
}

variable "tempo_s3_secret_key" {
  type        = string
  description = "Secret key for Tempo S3 secrets."
}

variable "tempo_s3_endpoint_url" {
  type        = string
  description = "Endpoint URL for Tempo S3 secrets."
}

variable "tempo_s3_region" {
  type        = string
  description = "(Optional) Region for Tempo S3 secrets."
  default     = ""
}

variable "kubernetes_namespace" {
  type        = string
  description = "Kubernetes namespace where secrets will be created."
  default     = "default" # Or your desired default namespace
}
