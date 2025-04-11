# modules/load-balancer/main.tf

# Create a load balancer for the Nginx Ingress Controller
resource "oci_load_balancer_load_balancer" "nginx_ingress_lb" {
  compartment_id = var.compartment_id
  display_name   = "${var.lb_name_prefix}-ingress-lb"
  shape          = "flexible"
  subnet_ids     = var.subnet_ids

  shape_details {
    minimum_bandwidth_in_mbps = var.lb_min_bandwidth
    maximum_bandwidth_in_mbps = var.lb_max_bandwidth
  }

  is_private = var.is_private

  # Optional: Network Security Groups
  network_security_group_ids = var.network_security_group_ids

  # Optional: Reserved IP
  reserved_ips {
    id = var.reserved_ip_id != "" ? var.reserved_ip_id : null
  }

  # Optional: Tags
  freeform_tags = {
    "Name"        = "${var.lb_name_prefix}-ingress-lb"
    "Environment" = var.environment
    "Purpose"     = "Ingress Controller"
  }
}

# Create a backend set for HTTP traffic (port 80)
resource "oci_load_balancer_backend_set" "http_backend_set" {
  load_balancer_id = oci_load_balancer_load_balancer.nginx_ingress_lb.id
  name             = "http-backend-set"
  policy           = "ROUND_ROBIN"

  health_checker {
    protocol          = "HTTP"
    port              = 80
    url_path          = "/healthz"
    return_code       = 200
    interval_ms       = 10000
    timeout_in_millis = 3000
    retries           = 3
  }
}

# Create a backend set for HTTPS traffic (port 443)
resource "oci_load_balancer_backend_set" "https_backend_set" {
  load_balancer_id = oci_load_balancer_load_balancer.nginx_ingress_lb.id
  name             = "https-backend-set"
  policy           = "ROUND_ROBIN"

  health_checker {
    protocol          = "HTTP"
    port              = 80
    url_path          = "/healthz"
    return_code       = 200
    interval_ms       = 10000
    timeout_in_millis = 3000
    retries           = 3
  }
}

# Create a listener for HTTP traffic (port 80)
resource "oci_load_balancer_listener" "http_listener" {
  load_balancer_id         = oci_load_balancer_load_balancer.nginx_ingress_lb.id
  name                     = "http-listener"
  default_backend_set_name = oci_load_balancer_backend_set.http_backend_set.name
  port                     = 80
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = 60
  }
}

# Create a listener for HTTPS traffic (port 443)
resource "oci_load_balancer_listener" "https_listener" {
  load_balancer_id         = oci_load_balancer_load_balancer.nginx_ingress_lb.id
  name                     = "https-listener"
  default_backend_set_name = oci_load_balancer_backend_set.https_backend_set.name
  port                     = 443
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = 60
  }
}
