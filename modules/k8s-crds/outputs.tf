# modules/k8s-crds/outputs.tf

output "cert_manager_namespace" {
  description = "The namespace where cert-manager is deployed"
  value       = var.cert_manager_namespace
}
