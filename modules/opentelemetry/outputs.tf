# modules/opentelemetry/outputs.tf

output "tempo_service_name" {
  description = "The name of the Tempo service"
  value       = "tempo"
}

output "otel_collector_service_name" {
  description = "The name of the OpenTelemetry Collector service"
  value       = "opentelemetry-collector"
}

output "otel_namespace" {
  description = "The namespace where OpenTelemetry components are deployed"
  value       = var.otel_namespace
}
