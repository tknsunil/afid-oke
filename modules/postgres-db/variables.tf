
variable "chart_version" {
  description = "Version of the PostgreSQL Helm chart"
  type        = string
  default     = "15.3.11"
}

variable "chart_repository" {
  description = "Repository URL for the PostgreSQL Helm chart"
  type        = string
  default     = "https://charts.bitnami.com/bitnami"
}

variable "values" {
  description = "Additional values to pass to the Helm chart"
  type        = map(any)
  default     = {}
}

variable "namespace" {
  description = "Kubernetes namespace for PostgreSQL"
  type        = string
  default     = "default"

}

variable "storage_class" {
  description = "Storage class for PostgreSQL PVCs"
  type        = string
  default     = "oci-bv"
}

variable "pvc_size" {
  description = "Size of the PVC for PostgreSQL"
  type        = string
  default     = "10Gi"
}

variable "postgres_password" {
  description = "Password for the PostgreSQL admin user"
  type        = string
  sensitive   = true
  default     = ""
}

variable "postgres_username" {
  description = "Username for the PostgreSQL admin user"
  type        = string
  default     = "postgres"
}

variable "postgres_database" {
  description = "Name of the default PostgreSQL database"
  type        = string
  default     = "postgres"
}

variable "postgres_port" {
  description = "Port for PostgreSQL"
  type        = number
  default     = 5432
}
