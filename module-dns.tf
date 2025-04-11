module "dns" {
  source = "./modules/dns"

  app_ip_address     = module.ingress.load_balancer_ip
  app_subdomain      = var.app_subdomain
  cloudflare_zone_id = var.cloudflare_zone_id

  depends_on = [
    module.ingress.load_balancer_ip,
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

