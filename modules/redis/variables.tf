
variable "chart_version" {
  description = "Version of the Redis Helm chart"
  type        = string
  default     = "17.9.5"
}

variable "chart_repository" {
  description = "Repository URL for the Redis Helm chart"
  type        = string
  default     = "https://charts.bitnami.com/bitnami"
}

variable "release_name" {
  description = "Name of the Helm release"
  type        = string
  default     = "redis"
}


