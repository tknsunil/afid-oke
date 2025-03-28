resource "oci_objectstorage_bucket" "django_store" {
  compartment_id = var.compartment_id
  name           = "afid-django-${var.environment}-store-7945"
  namespace      = var.object_storage_namespace
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
  namespace      = var.object_storage_namespace
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
  namespace      = var.object_storage_namespace
  access_type    = var.tempo_bucket_access_type
  versioning     = var.tempo_bucket_versioning
  kms_key_id     = var.kms_key_id

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
