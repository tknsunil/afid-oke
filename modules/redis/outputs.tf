

output "service_name" {
  description = "The name of the Redis service"
  value       = "afid-redis"
}

output "port" {
  description = "The port of the Redis service"
  value       = 6379
}

output "connection_string" {
  description = "The connection string for Redis"
  value       = "redis://afid-redis.default.svc.cluster.local:6379"
}

