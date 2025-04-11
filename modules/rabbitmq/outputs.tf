# modules/rabbitmq/outputs.tf

output "rabbitmq_service_name" {
  description = "The name of the RabbitMQ service"
  value       = "rabbitmq"
}

output "rabbitmq_namespace" {
  description = "The namespace where RabbitMQ is deployed"
  value       = var.rabbitmq_namespace
}
