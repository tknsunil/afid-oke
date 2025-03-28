# modules/object-storage/main.tf

data "oci_objectstorage_namespace" "current_namespace" {}

resource "oci_objectstorage_bucket" "django_store" {
  compartment_id = var.compartment_id
  name           = "afid-django-${var.environment}-store-7945"
  namespace      = data.oci_objectstorage_namespace.current_namespace.namespace
  access_type    = var.django_bucket_access_type
  versioning     = var.django_bucket_versioning
  kms_key_id     = var.kms_key_id

  retention_rules {
    display_name = "django_retention"

    duration {
      time_amount = var.django_retention_time_amount
      time_unit   = var.django_retention_time_unit
    }
  }

  freeform_tags = {
    "Environment" = var.environment
    "Application" = "Django"
    "Purpose"     = "Object Storage for Django App"
  }
}

resource "oci_objectstorage_bucket" "loki_store" {
  compartment_id = var.compartment_id
  name           = "afid-loki-${var.environment}-data-store-7945"
  namespace      = data.oci_objectstorage_namespace.current_namespace.namespace
  access_type    = var.loki_bucket_access_type
  versioning     = var.loki_bucket_versioning
  kms_key_id     = var.kms_key_id

  retention_rules {
    display_name = "loki_retention"

    duration {
      time_amount = var.loki_retention_time_amount
      time_unit   = var.loki_retention_time_unit
    }
  }

  freeform_tags = {
    "Environment" = var.environment
    "Application" = "Loki"
    "Purpose"     = "Object Storage for Loki Data"
  }
}

resource "oci_objectstorage_bucket" "tempo_store" {
  compartment_id = var.compartment_id
  name           = "afid-tempo-${var.environment}-data-store-7945"
  namespace      = data.oci_objectstorage_namespace.current_namespace.namespace

  access_type = var.tempo_bucket_access_type
  versioning  = var.tempo_bucket_versioning
  kms_key_id  = var.kms_key_id

  retention_rules {
    display_name = "tempo_retention"

    duration {
      time_amount = var.tempo_retention_time_amount
      time_unit   = var.tempo_retention_time_unit
    }
  }

  freeform_tags = {
    "Environment" = var.environment
    "Application" = "Tempo"
    "Purpose"     = "Object Storage for Tempo Data"
  }
}

# IAM User for Bucket Access
resource "oci_identity_user" "bucket_access_user" {
  compartment_id = var.compartment_id
  description    = "User for programmatic access to object storage buckets for ${var.environment} environment"
  name           = "afid-bucket-access-user-${var.environment}" # Consider making the suffix more dynamic if needed
}

# API Key for the IAM User
resource "oci_identity_api_key" "bucket_access_api_key" {
  user_id   = oci_identity_user.bucket_access_user.id
  key_value = tls_private_key.api_key.public_key_pem # Use public_key_pem for PEM format

  lifecycle {
    create_before_destroy = true # ensure API key is created before destroying the user (important for state management)
  }
}

resource "tls_private_key" "api_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# IAM Policy to Grant Permissions (Object Read for now - adjust as needed)
resource "oci_identity_policy" "bucket_access_policy" {
  compartment_id = var.compartment_id
  name           = "afid-bucket-access-policy-${var.environment}" # Consider making the suffix more dynamic if needed
  description    = "Policy to grant read access to object storage buckets for ${var.environment} environment"

  statements = [
    "Allow group afid-bucket-access-group-${var.environment} to read objects in compartment ${var.compartment_id} where target.bucket.name='afid-django-${var.environment}-store-7945'",
    "Allow group afid-bucket-access-group-${var.environment} to read objects in compartment ${var.compartment_id} where target.bucket.name='afid-loki-${var.environment}-data-store-7945'",
    "Allow group afid-bucket-access-group-${var.environment} to read objects in compartment ${var.compartment_id} where target.bucket.name='afid-tempo-${var.environment}-data-store-7945'",
  ]

  lifecycle {
    create_before_destroy = true # Ensure policy exists before user is created
  }
}

# IAM Group for the User (Best Practice for Policy Management)
resource "oci_identity_group" "bucket_access_group" {
  compartment_id = var.compartment_id
  description    = "Group for users accessing object storage buckets for ${var.environment} environment"
  name           = "afid-bucket-access-group-${var.environment}" # Consider making the suffix more dynamic if needed
}

# Add User to the Group
resource "oci_identity_user_group_membership" "bucket_access_membership" {
  group_id = oci_identity_group.bucket_access_group.id
  user_id  = oci_identity_user.bucket_access_user.id
}
