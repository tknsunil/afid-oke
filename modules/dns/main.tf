
resource "cloudflare_dns_record" "dns_record_main" {
  zone_id = var.cloudflare_zone_id
  comment = "Main DNS record"
  content = var.app_ip_address
  name    = var.app_subdomain
  type    = "A"
  ttl     = 3600
  proxied = false
}

resource "cloudflare_dns_record" "dns_record_wildcard" {
  zone_id = var.cloudflare_zone_id
  comment = "Wildcard DNS record"
  name    = "*.${var.app_subdomain}"
  content = var.app_ip_address
  type    = "A"
  ttl     = 3600
  proxied = false
}
