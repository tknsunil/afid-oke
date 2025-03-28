variable "compartment_id" {
  type        = string
  description = "The OCID of the compartment where the buckets will be created."
}

variable "region" {
  type        = string
  description = "The OCI region where the buckets will be created."
  default     = "ap-sydney-1"
}

variable "environment" {
  type        = string
  description = "The environment (e.g., prod, staging, dev)."
  default     = "prod"
}

# Django Bucket Variables
variable "django_retention_time_amount" {
  type        = number
  description = "Retention time amount for Django bucket."
  default     = 30
}

variable "django_retention_time_unit" {
  type        = string
  description = "Retention time unit for Django bucket (DAYS, MONTHS, YEARS)."
  default     = "DAYS"
}

variable "django_bucket_access_type" {
  type        = string
  description = "Access type for Django bucket (NoPublicAccess, ObjectRead, ObjectReadWithoutList)."
  default     = "NoPublicAccess"
}

variable "django_bucket_versioning" {
  type        = string
  description = "Versioning status for Django bucket (Enabled, Disabled, Suspended)."
  default     = "Disabled"
}

# Loki Bucket Variables
variable "loki_retention_time_amount" {
  type        = number
  description = "Retention time amount for Loki bucket."
  default     = 30
}

variable "loki_retention_time_unit" {
  type        = string
  description = "Retention time unit for Loki bucket (DAYS, MONTHS, YEARS)."
  default     = "DAYS"
}

variable "loki_bucket_access_type" {
  type        = string
  description = "Access type for Loki bucket (NoPublicAccess, ObjectRead, ObjectReadWithoutList)."
  default     = "NoPublicAccess"
}
variable "loki_bucket_versioning" {
  type        = string
  description = "Versioning status for Loki bucket (Enabled, Disabled, Suspended)."
  default     = "Disabled"
}

# Tempo Bucket Variables
variable "tempo_retention_time_amount" {
  type        = number
  description = "Retention time amount for Tempo bucket."
  default     = 30
}

variable "tempo_retention_time_unit" {
  type        = string
  description = "Retention time unit for Tempo bucket (DAYS, MONTHS, YEARS)."
  default     = "DAYS"
}

variable "tempo_bucket_access_type" {
  type        = string
  description = "Access type for Tempo bucket (NoPublicAccess, ObjectRead, ObjectReadWithoutList)."
  default     = "NoPublicAccess"
}

variable "tempo_bucket_versioning" {
  type        = string
  description = "Versioning status for Tempo bucket (Enabled, Disabled, Suspended)."
  default     = "Disabled"
}

# KMS Key ID (Optional, shared for all buckets for simplicity - can be further separated if needed)
variable "kms_key_id" {
  type        = string
  description = "The OCID of the KMS key to use for encryption (optional, shared for all buckets)."
  default     = ""
}
