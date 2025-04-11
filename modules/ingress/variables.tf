# modules/ingress/variables.tf

variable "ingress_namespace" {
  description = "Kubernetes namespace for Nginx Ingress controller"
  type        = string
}

variable "nginx_ingress_helm_version" {
  description = "Helm chart version for Nginx Ingress Controller"
  type        = string
}

variable "subdomain" {
  description = "Subdomain for application services (used for ingress hostnames)"
  type        = string
}

variable "monitoring_namespace" {
  description = "Kubernetes namespace for monitoring components"
  type        = string
}

variable "rabbitmq_namespace" {
  description = "Kubernetes namespace for RabbitMQ"
  type        = string
}

variable "enable_monitoring" {
  description = "Whether monitoring is enabled"
  type        = bool
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}


# Load balancer variables
variable "use_pre_created_lb" {
  description = "Whether to use a pre-created load balancer"
  type        = bool
  default     = false
}

variable "load_balancer_id" {
  description = "The OCID of the pre-created load balancer"
  type        = string
  default     = ""
}

variable "http_backend_set_name" {
  description = "The name of the HTTP backend set in the pre-created load balancer"
  type        = string
  default     = ""
}

variable "https_backend_set_name" {
  description = "The name of the HTTPS backend set in the pre-created load balancer"
  type        = string
  default     = ""
}

variable "lb_min_bandwidth" {
  description = "Minimum bandwidth for the flexible shape load balancer (in Mbps)"
  type        = number
  default     = 10
}

variable "lb_max_bandwidth" {
  description = "Maximum bandwidth for the flexible shape load balancer (in Mbps)"
  type        = number
  default     = 100
}
