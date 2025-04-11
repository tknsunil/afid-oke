# modules/monitoring/outputs.tf

output "grafana_service_name" {
  description = "The name of the Grafana service"
  value       = "grafana"
}

output "loki_service_name" {
  description = "The name of the Loki service"
  value       = "loki"
}

output "monitoring_namespace" {
  description = "The namespace where monitoring components are deployed"
  value       = var.monitoring_namespace
}
