
output "service_name" {
  description = "The name of the PostgreSQL service"
  value       = "postgres-db-postgresql"
}

output "connection_string" {
  description = "The connection string for PostgreSQL"
  value       = "postgresql://${var.postgres_username}:${var.postgres_password}@postgres-db-postgresql.${var.namespace}.svc.cluster.local:${var.postgres_port}/${var.postgres_database}"
  sensitive   = true
}
