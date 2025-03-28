output "django_bucket_name" {
  value       = oci_objectstorage_bucket.django_store.name
  description = "The name of the Django object storage bucket."
}

output "django_bucket_id" {
  value       = oci_objectstorage_bucket.django_store.id
  description = "The ID of the Django bucket"
}

output "django_bucket_access_key" {
  value       = oci_objectstorage_bucket.django_store.access_key
  description = "The access key of the Django bucket"
}

output "django_bucket_secret_key" {
  value       = oci_objectstorage_bucket.django_store.secret_key
  description = "The secret key of the Django bucket"
}

output "django_bucket_endpoint" {
  value       = oci_objectstorage_bucket.django_store.endpoint
  description = "The endpoint of the Django bucket"
}

output "django_bucket_region" {
  value       = oci_objectstorage_bucket.django_store.region
  description = "The region of the Django bucket"
}


output "loki_bucket_name" {
  value       = oci_objectstorage_bucket.loki_store.name
  description = "The name of the Loki object storage bucket."
}

output "loki_bucket_id" {
  value       = oci_objectstorage_bucket.loki_store.id
  description = "The ID of the Loki bucket"
}

output "loki_bucket_access_key" {
  value       = oci_objectstorage_bucket.loki_store.access_key
  description = "The access key of the Loki bucket"
}

output "loki_bucket_secret_key" {
  value       = oci_objectstorage_bucket.loki_store.secret_key
  description = "The secret key of the Loki bucket"
}

output "loki_bucket_endpoint" {
  value       = oci_objectstorage_bucket.loki_store.endpoint
  description = "The endpoint of the Loki bucket"
}

output "loki_bucket_region" {
  value       = oci_objectstorage_bucket.loki_store.region
  description = "The region of the Loki bucket"
}

output "tempo_bucket_name" {
  value       = oci_objectstorage_bucket.tempo_store.name
  description = "The name of the Tempo object storage bucket."
}

output "tempo_bucket_id" {
  value       = oci_objectstorage_bucket.tempo_store.id
  description = "The ID of the Tempo bucket"
}

output "tempo_bucket_access_key" {
  value       = oci_objectstorage_bucket.tempo_store.access_key
  description = "The access key of the Tempo bucket"
}

output "tempo_bucket_secret_key" {
  value       = oci_objectstorage_bucket.tempo_store.secret_key
  description = "The secret key of the Tempo bucket"
}

output "tempo_bucket_endpoint" {
  value       = oci_objectstorage_bucket.tempo_store.endpoint
  description = "The endpoint of the Tempo bucket"
}

output "tempo_bucket_region" {
  value       = oci_objectstorage_bucket.tempo_store.region
  description = "The region of the Tempo bucket"
}

output "object_storage_namespace" {
  value       = var.object_storage_namespace
  description = "The object storage namespace being used"
}

output "compartment_id" {
  value       = var.compartment_id
  description = "Compartment where the buckets are created."
}
