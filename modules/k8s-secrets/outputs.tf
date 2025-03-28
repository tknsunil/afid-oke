output "django_secret_name" {
  value       = kubernetes_secret.django_s3_secrets.metadata[0].name
  description = "Name of the Django S3 secrets Kubernetes secret."
}

output "loki_secret_name" {
  value       = kubernetes_secret.loki_s3_secrets.metadata[0].name
  description = "Name of the Loki S3 secrets Kubernetes secret."
}

output "tempo_secret_name" {
  value       = kubernetes_secret.tempo_s3_secrets.metadata[0].name
  description = "Name of the Tempo S3 secrets Kubernetes secret."
}
 
