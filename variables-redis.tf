# Redis variables
variable "redis_enabled" {
  description = "Whether to deploy Redis"
  type        = bool
  default     = false
}

variable "redis_namespace" {
  description = "Kubernetes namespace for Redis"
  type        = string
  default     = "default"
}

variable "redis_create_namespace" {
  description = "Whether to create the namespace for Redis"
  type        = bool
  default     = false
}

variable "redis_release_name" {
  description = "Name of the Redis Helm release"
  type        = string
  default     = "redis"
}

variable "redis_chart_version" {
  description = "Version of the Redis Helm chart"
  type        = string
  default     = "17.9.5"
}

variable "redis_architecture" {
  description = "Redis architecture (standalone, replication)"
  type        = string
  default     = "standalone"
}

variable "redis_full_name_override" {
  description = "Override the full name of the Redis deployment"
  type        = string
  default     = "afid-redis"
}

variable "redis_auth_enabled" {
  description = "Enable Redis authentication"
  type        = bool
  default     = false
}

variable "redis_auth_password" {
  description = "Redis password (if auth_enabled is true)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "redis_master_port" {
  description = "Redis master port"
  type        = number
  default     = 6379
}

variable "redis_master_resources_limits_cpu" {
  description = "CPU limits for Redis master"
  type        = string
  default     = "500m"
}

variable "redis_master_resources_limits_memory" {
  description = "Memory limits for Redis master"
  type        = string
  default     = "512Mi"
}

variable "redis_master_resources_requests_cpu" {
  description = "CPU requests for Redis master"
  type        = string
  default     = "250m"
}

variable "redis_master_resources_requests_memory" {
  description = "Memory requests for Redis master"
  type        = string
  default     = "256Mi"
}

variable "redis_replica_count" {
  description = "Number of Redis replicas (only used when architecture is replication)"
  type        = number
  default     = 2
}

variable "redis_replica_resources_limits_cpu" {
  description = "CPU limits for Redis replicas"
  type        = string
  default     = "500m"
}

variable "redis_replica_resources_limits_memory" {
  description = "Memory limits for Redis replicas"
  type        = string
  default     = "512Mi"
}

variable "redis_replica_resources_requests_cpu" {
  description = "CPU requests for Redis replicas"
  type        = string
  default     = "250m"
}

variable "redis_replica_resources_requests_memory" {
  description = "Memory requests for Redis replicas"
  type        = string
  default     = "256Mi"
}

variable "redis_persistence_enabled" {
  description = "Enable Redis persistence"
  type        = bool
  default     = true
}

variable "redis_persistence_storage_class" {
  description = "Storage class for Redis persistence"
  type        = string
  default     = ""
}

variable "redis_persistence_size" {
  description = "Size of the persistent volume for Redis"
  type        = string
  default     = "8Gi"
}

variable "redis_metrics_enabled" {
  description = "Enable Redis metrics exporter"
  type        = bool
  default     = false
}

variable "redis_service_type" {
  description = "Kubernetes service type for Redis"
  type        = string
  default     = "ClusterIP"
}

variable "redis_values" {
  description = "Additional values to pass to the Redis Helm chart"
  type        = map(any)
  default     = {}
}
