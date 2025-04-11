# modules/load-balancer/outputs.tf

output "load_balancer_id" {
  description = "The OCID of the created load balancer"
  value       = oci_load_balancer_load_balancer.nginx_ingress_lb.id
}

output "load_balancer_ip" {
  description = "The public IP address of the load balancer"
  value       = oci_load_balancer_load_balancer.nginx_ingress_lb.ip_address_details[0].ip_address
}

output "load_balancer_name" {
  description = "The name of the created load balancer"
  value       = oci_load_balancer_load_balancer.nginx_ingress_lb.display_name
}

output "http_backend_set_name" {
  description = "The name of the HTTP backend set"
  value       = oci_load_balancer_backend_set.http_backend_set.name
}

output "https_backend_set_name" {
  description = "The name of the HTTPS backend set"
  value       = oci_load_balancer_backend_set.https_backend_set.name
}
