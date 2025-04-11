
module "ingress" {
  # count  = 0
  source = "./modules/ingress"

  ingress_namespace          = var.ingress_namespace
  nginx_ingress_helm_version = var.nginx_ingress_helm_version
  subdomain                  = var.app_subdomain
  monitoring_namespace       = var.monitoring_namespace
  rabbitmq_namespace         = var.rabbitmq_namespace
  enable_monitoring          = var.enable_monitoring
  environment                = "dev"

  # Load balancer configuration
  use_pre_created_lb     = false
  load_balancer_id       = ""
  http_backend_set_name  = ""
  https_backend_set_name = ""
  lb_min_bandwidth       = var.lb_min_bandwidth
  lb_max_bandwidth       = var.lb_max_bandwidth


  depends_on = [
    module.kubernetes_crds,
    time_sleep.kubeconfig_setup
  ]
}

output "app_ip_address" {
  value = module.ingress.load_balancer_ip
}
