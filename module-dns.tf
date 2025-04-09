module "dns" {
  source = "./modules/dns"

  app_ip_address     = var.app_ip_address
  app_subdomain      = var.app_subdomain
  cloudflare_zone_id = var.cloudflare_zone_id

  depends_on = [
    module.cluster[0].oci_containerengine_cluster,
  ]
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Cloudflare zone id"
}

variable "app_subdomain" {
  type        = string
  description = "Subdomain for the application"
}

variable "app_ip_address" {
  type        = string
  description = "IP address for the application"
}
