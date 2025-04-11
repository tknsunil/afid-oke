
output "object_storage_s3_endpoint" {
  value       = "https://${data.oci_objectstorage_namespace.current_namespace.namespace}.compat.objectstorage.${var.region}.oraclecloud.com"
  description = "S3 compatible endpoint for OCI Object Storage"
}

output "object_storage_region" {
  value       = var.region
  description = "OCI Region where Object Storage is deployed"
}

# Outputs for IAM User Credentials (S3 Compatible Keys)
output "bucket_access_key" {
  value       = oci_identity_user.bucket_access_user.id
  description = "S3 Access Key ID for bucket access. This is the OCID of the IAM user."
}

output "bucket_access_secret_key" {
  value       = oci_identity_customer_secret_key.bucket_access_key.key
  description = "S3 Secret Access Key for bucket access. This is the private key of the IAM user's API key."
  sensitive   = true
}

output "bucket_access_api_key_fingerprint" {
  value       = oci_identity_api_key.bucket_access_api_key.fingerprint
  description = "Fingerprint of the created API key. Use this to verify the API key in the OCI Console."
}

output "django_bucket_name" {
  value       = oci_objectstorage_bucket.django_store.name
  description = "The name of the Django object storage bucket."
}

output "django_bucket_id" {
  value       = oci_objectstorage_bucket.django_store.id
  description = "The ID of the Django bucket"
}


output "loki_bucket_name" {
  value       = oci_objectstorage_bucket.loki_store.name
  description = "The name of the Loki object storage bucket."
}

output "loki_bucket_id" {
  value       = oci_objectstorage_bucket.loki_store.id
  description = "The ID of the Loki bucket"
}

output "tempo_bucket_name" {
  value       = oci_objectstorage_bucket.tempo_store.name
  description = "The name of the Tempo object storage bucket."
}

output "tempo_bucket_id" {
  value       = oci_objectstorage_bucket.tempo_store.id
  description = "The ID of the Tempo bucket"
}


output "object_storage_namespace" {
  value       = data.oci_objectstorage_namespace.current_namespace.namespace
  description = "The object storage namespace being used"
}

output "compartment_id" {
  value       = var.compartment_id
  description = "Compartment where the buckets are created."
}


