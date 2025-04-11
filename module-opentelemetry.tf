module "opentelemetry" {
  #   count  = var.enable_otel ? 1 : 0
  source = "./modules/opentelemetry"

  otel_collector_helm_version = "0.120.2"
  otel_namespace              = "monitoring"
  tempo_bucket_name           = module.object_storage.tempo_bucket_name
  tempo_s3_endpoint_url       = module.object_storage.object_storage_s3_endpoint
  tempo_s3_region             = module.object_storage.object_storage_region
  tempo_s3_access_key         = module.object_storage.bucket_access_key
  tempo_s3_secret_key         = module.object_storage.bucket_access_secret_key
  tempo_helm_version          = "1.14.0"

  depends_on = [
    time_sleep.kubeconfig_setup
  ]
}
