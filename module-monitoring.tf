module "monitoring" {
  source = "./modules/monitoring"

  loki_s3_endpoint_url               = module.object_storage.object_storage_s3_endpoint
  loki_bucket_name                   = module.object_storage.loki_bucket_name
  loki_s3_region                     = module.object_storage.object_storage_region
  loki_s3_secret_key                 = module.object_storage.bucket_access_secret_key
  loki_s3_access_key                 = module.object_storage.bucket_access_key
  loki_helm_version                  = "5.5.0"
  monitoring_namespace               = "monitoring"
  vector_helm_version                = "0.21.1"
  kube_prometheus_stack_helm_version = "45.25.0"
  app_subdomain                      = var.app_subdomain
  grafana_github_oauth_client_id     = var.grafana_github_oauth_client_id
  grafana_github_oauth_client_secret = var.grafana_github_oauth_client_secret
  maxmind_licence_key                = var.maxmind_licence_key

  depends_on = [time_sleep.kubeconfig_setup]
}
