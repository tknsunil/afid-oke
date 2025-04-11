# variables-monitoring.tf

variable "enable_monitoring" {
  description = "Whether to enable monitoring stack with Loki, Grafana, and Vector"
  type        = bool
  default     = false
}

variable "enable_otel" {
  description = "Whether to enable OpenTelemetry collector with Tempo"
  type        = bool
  default     = false
}

variable "monitoring_namespace" {
  description = "Kubernetes namespace for monitoring components"
  type        = string
  default     = "monitoring"
}

variable "otel_namespace" {
  description = "Kubernetes namespace for OpenTelemetry components"
  type        = string
  default     = "monitoring"
}

variable "rabbitmq_namespace" {
  description = "Kubernetes namespace for RabbitMQ"
  type        = string
  default     = "default"
}

variable "ingress_namespace" {
  description = "Kubernetes namespace for Nginx Ingress controller"
  type        = string
  default     = "default"
}

variable "cert_manager_namespace" {
  description = "Kubernetes namespace for cert-manager"
  type        = string
  default     = "default"
}

variable "loki_helm_version" {
  description = "Helm chart version for Loki"
  type        = string
  default     = "5.41.6" # Grafana Loki chart version
}

variable "grafana_helm_version" {
  description = "Helm chart version for Grafana"
  type        = string
  default     = "7.0.21" # Grafana chart version
}

variable "vector_helm_version" {
  description = "Helm chart version for Vector"
  type        = string
  default     = "0.28.0" # Vector chart version
}

variable "otel_collector_helm_version" {
  description = "Helm chart version for OpenTelemetry Collector"
  type        = string
  default     = "0.70.0" # OpenTelemetry Collector chart version
}

variable "tempo_helm_version" {
  description = "Helm chart version for Tempo"
  type        = string
  default     = "1.7.1" # Tempo chart version
}

variable "rabbitmq_helm_version" {
  description = "Helm chart version for RabbitMQ"
  type        = string
  default     = "12.0.3" # RabbitMQ chart version
}

variable "nginx_ingress_helm_version" {
  description = "Helm chart version for Nginx Ingress Controller"
  type        = string
  default     = "4.8.3" # Nginx Ingress Controller chart version
}

variable "cert_manager_helm_version" {
  description = "Helm chart version for cert-manager"
  type        = string
  default     = "v1.13.3" # cert-manager chart version
}

variable "letsencrypt_email" {
  description = "Email address for Let's Encrypt certificate notifications"
  type        = string
  default     = ""
}

variable "letsencrypt_server" {
  description = "Let's Encrypt server URL (use staging for testing)"
  type        = string
  default     = "https://acme-v02.api.letsencrypt.org/directory" # Production server
}

# Load Balancer variables
variable "create_load_balancer" {
  description = "Whether to create a dedicated load balancer for the ingress controller"
  type        = bool
  default     = true
}

variable "lb_subnet_ids" {
  description = "List of subnet OCIDs where the load balancer will be placed"
  type        = list(string)
  default     = []
}

variable "lb_name_prefix" {
  description = "Prefix for the load balancer name"
  type        = string
  default     = "afid"
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

variable "lb_is_private" {
  description = "Whether the load balancer should be private (true) or public (false)"
  type        = bool
  default     = false
}

variable "lb_nsg_ids" {
  description = "List of network security group OCIDs to associate with the load balancer"
  type        = list(string)
  default     = []
}

variable "lb_reserved_ip_id" {
  description = "OCID of a reserved public IP to assign to the load balancer"
  type        = string
  default     = ""
}

# Storage variables for Loki
variable "loki_bucket_name" {
  description = "Name of the bucket for Loki logs"
  type        = string
  default     = "loki-logs"
}

# Storage variables for Tempo
variable "tempo_bucket_name" {
  description = "Name of the bucket for Tempo traces"
  type        = string
  default     = "tempo-traces"
}
