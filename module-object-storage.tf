module "object_storage" {
  source = "./modules/object-storage"

  compartment_id               = var.compartment_id
  region                       = var.region
  environment                  = "test"
  django_retention_time_amount = 10
  loki_retention_time_amount   = 10
  tempo_retention_time_amount  = 10

}

output "django_bucket" {
  value = module.object_storage.django_bucket_name
}

output "loki_bucket" {
  value = module.object_storage.loki_bucket_name
}

output "tempo_bucket" {
  value = module.object_storage.tempo_bucket_name
}
