# module-k8s-secrets.tf

module "kubernetes_s3_secrets" {
  source = "./modules/k8s-secrets"

  # Django S3 Secrets - Allow override, default to generated keys from object_storage module
  django_s3_access_key   = var.django_s3_access_key != "" ? var.django_s3_access_key : module.object_storage.bucket_access_key
  django_s3_secret_key   = var.django_s3_secret_key != "" ? var.django_s3_secret_key : module.object_storage.bucket_access_secret_key
  django_s3_endpoint_url = module.object_storage.object_storage_s3_endpoint
  django_s3_region       = module.object_storage.object_storage_region

  # Loki S3 Secrets - Allow override, default to generated keys from object_storage module
  loki_s3_access_key   = var.loki_s3_access_key != "" ? var.loki_s3_access_key : module.object_storage.bucket_access_key
  loki_s3_secret_key   = var.loki_s3_secret_key != "" ? var.loki_s3_secret_key : module.object_storage.bucket_access_secret_key
  loki_s3_endpoint_url = module.object_storage.object_storage_s3_endpoint
  loki_s3_region       = module.object_storage.object_storage_region

  # Tempo S3 Secrets - Allow override, default to generated keys from object_storage module
  tempo_s3_access_key   = var.tempo_s3_access_key != "" ? var.tempo_s3_access_key : module.object_storage.bucket_access_key
  tempo_s3_secret_key   = var.tempo_s3_secret_key != "" ? var.tempo_s3_secret_key : module.object_storage.bucket_access_secret_key
  tempo_s3_endpoint_url = module.object_storage.object_storage_s3_endpoint
  tempo_s3_region       = module.object_storage.object_storage_region
}


variable "django_s3_access_key" {
  type        = string
  description = "Access key for Django S3 secrets."
  default     = ""

}

variable "django_s3_secret_key" {
  type        = string
  description = "Secret key for Django S3 secrets."
  default     = ""
}

variable "django_s3_endpoint_url" {
  type        = string
  description = "Endpoint URL for Django S3 secrets."
  default     = ""
}

variable "django_s3_region" {
  type        = string
  description = "(Optional) Region for Django S3 secrets."
  default     = ""
}

variable "loki_s3_access_key" {
  type        = string
  description = "Access key for Loki S3 secrets."
  default     = ""
}

variable "loki_s3_secret_key" {
  type        = string
  description = "Secret key for Loki S3 secrets."
  default     = ""
}

variable "loki_s3_endpoint_url" {
  type        = string
  description = "Endpoint URL for Loki S3 secrets."
  default     = ""
}

variable "loki_s3_region" {
  type        = string
  description = "(Optional) Region for Loki S3 secrets."
  default     = ""
}

variable "tempo_s3_access_key" {
  type        = string
  description = "Access key for Tempo S3 secrets."
  default     = ""
}

variable "tempo_s3_secret_key" {
  type        = string
  description = "Secret key for Tempo S3 secrets."
  default     = ""
}

variable "tempo_s3_endpoint_url" {
  type        = string
  description = "Endpoint URL for Tempo S3 secrets."
  default     = ""
}

variable "tempo_s3_region" {
  type        = string
  description = "(Optional) Region for Tempo S3 secrets."
  default     = ""
}
