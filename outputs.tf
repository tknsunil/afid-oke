# outputs.tf


output "load_balancer_id" {
  description = "The OCID of the load balancer for the ingress controller"
  value       = null
}

output "load_balancer_name" {
  description = "The name of the load balancer for the ingress controller"
  value       = null
}

output "grafana_url" {
  description = "URL for accessing Grafana dashboard"
  value       = var.enable_monitoring ? "https://monitoring.${var.app_subdomain}" : null
}

output "rabbitmq_url" {
  description = "URL for accessing RabbitMQ management dashboard"
  value       = "https://rabbitmq.${var.app_subdomain}"
}

output "application_url" {
  description = "URL for accessing the main application"
  value       = "https://${var.app_subdomain}"
}

output "kubeconfig_path" {
  description = "Path to the generated kubeconfig file"
  value       = abspath(local_file.kube_config_file.filename)
}
