# modules/rabbitmq/variables.tf

variable "rabbitmq_namespace" {
  description = "Kubernetes namespace for RabbitMQ"
  type        = string
  default     = "default"
}

variable "rabbitmq_helm_version" {
  description = "Helm chart version for RabbitMQ"
  type        = string
  default     = "11.14.5"
}

variable "rabbitmq_auth_password" {
  description = "Password for RabbitMQ admin user"
  type        = string
  default     = "rabbitmq-auth"
  sensitive   = true
}

variable "rabbitmq_auth_erlang_cookie" {
  description = "Erlang cookie for RabbitMQ cluster"
  type        = string
  default     = "rabbitmq-auth"
  sensitive   = true
}

