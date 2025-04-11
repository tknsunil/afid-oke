
resource "kubernetes_secret" "postgres_db_passwords" {

  metadata {
    name      = "postgres-db-pass"
    namespace = var.namespace
  }

  data = {
    username = var.postgres_username
    password = var.postgres_password
    database = var.postgres_database
    port     = var.postgres_port
  }

  type = "Opaque"
}


resource "helm_release" "postgresql" {

  name            = "afid-postgres"
  repository      = var.chart_repository
  chart           = "postgresql"
  version         = var.chart_version
  namespace       = var.namespace
  atomic          = true
  cleanup_on_fail = true

  set {
    name  = "global.postgresql.auth.username"
    value = var.postgres_username
  }

  set {
    name  = "global.postgresql.auth.password"
    value = var.postgres_password
  }

  set {
    name  = "global.postgresql.auth.database"
    value = var.postgres_database
  }

  set {
    name  = "primary.persistence.storageClass"
    value = var.storage_class
  }

  set {
    name  = "primary.persistence.size"
    value = var.pvc_size
  }

  set {
    name  = "service.ports.postgresql"
    value = var.postgres_port
  }

  dynamic "set" {
    for_each = var.values
    content {
      name  = set.key
      value = set.value
    }
  }

  timeout = 600
  wait    = true
}
