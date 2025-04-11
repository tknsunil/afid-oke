# modules/ingress/outputs.tf

output "load_balancer_ip" {
  description = "The IP address of the load balancer"
  value       = data.kubernetes_service.nginx_ingress.status.0.load_balancer.0.ingress.0.ip
}

output "ingress_namespace" {
  description = "The namespace where Nginx Ingress controller is deployed"
  value       = var.ingress_namespace
}
