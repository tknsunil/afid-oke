resource "kubernetes_secret" "django_s3_secrets" {
  lifecycle {
    ignore_changes = [metadata]
  }
  metadata {
    name      = "django-s3-secrets"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"

  data = {
    access-key   = var.django_s3_access_key
    secret-key   = var.django_s3_secret_key
    endpoint-url = var.django_s3_endpoint_url
    region       = var.django_s3_region != "" ? var.django_s3_region : ""
  }
}

resource "kubernetes_secret" "loki_s3_secrets" {
  lifecycle {
    ignore_changes = [metadata]
  }
  metadata {
    name      = "loki-s3-secrets"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"

  data = {
    access-key   = var.loki_s3_access_key
    secret-key   = var.loki_s3_secret_key
    endpoint-url = var.loki_s3_endpoint_url
    region       = var.loki_s3_region != "" ? var.loki_s3_region : ""
  }
}

resource "kubernetes_secret" "tempo_s3_secrets" {
  lifecycle {
    ignore_changes = [metadata]
  }
  metadata {
    name      = "tempo-s3-secrets"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"

  data = {
    access-key   = var.tempo_s3_access_key
    secret-key   = var.tempo_s3_secret_key
    endpoint-url = var.tempo_s3_endpoint_url
    region       = var.tempo_s3_region != "" ? var.tempo_s3_region : ""
  }
}

# Assumes you have a variable named "kubernetes_namespace" defined
# Assumes you have a variable named "cloudflare_api_token_value" defined for the plain text token

resource "kubernetes_secret" "cloudflare_api_token" {
  lifecycle {
    ignore_changes = [
      metadata,
    ]
  }

  metadata {
    name      = "cloudflare-api-token"
    namespace = var.kubernetes_namespace
  }

  type = "Opaque"
  data = {
    token = var.cloudflare_api_token_value
  }
}

resource "kubernetes_secret" "django_github_oauth" {
  lifecycle { ignore_changes = [metadata] }
  metadata {
    name      = "django-github-oauth"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"
  # Terraform auto-encodes values for Opaque secrets
  data = {
    "client-id"     = var.django_github_oauth_client_id_value
    "client-secret" = var.django_github_oauth_client_secret_value
  }
}

resource "kubernetes_secret" "django_secret_key" {
  lifecycle { ignore_changes = [metadata] }
  metadata {
    name      = "django-secret-key"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"
  data = {
    key = var.django_secret_key_value
  }
}

resource "kubernetes_secret" "django_superuser" {
  lifecycle { ignore_changes = [metadata] }
  metadata {
    name      = "django-superuser"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"
  data = {
    email    = var.django_superuser_email_value
    password = var.django_superuser_password_value
    username = var.django_superuser_username_value
  }
}

resource "kubernetes_secret" "dockercred" {
  lifecycle { ignore_changes = [metadata] }
  metadata {
    name      = "dockercred"
    namespace = var.kubernetes_namespace
  }
  type = "kubernetes.io/dockerconfigjson"
  data = {
    ".dockerconfigjson" = base64encode(jsonencode({
      auths = {
        "${var.dockercred_registry_server_value}" = {
          username = var.dockercred_username_value
          password = var.dockercred_password_value
          email    = var.dockercred_email_value
          auth     = base64encode("${var.dockercred_username_value}:${var.dockercred_password_value}")
        }
      }
    }))
  }
}

resource "kubernetes_secret" "emtmlib_keys" {
  lifecycle { ignore_changes = [metadata] }
  metadata {
    name      = "emtmlib-keys"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"
  data = {
    key1 = var.emtmlib_keys_key1_value
    key2 = var.emtmlib_keys_key2_value
  }
}

resource "kubernetes_secret" "grafana_github_oauth" {
  lifecycle { ignore_changes = [metadata] }
  metadata {
    name      = "grafana-github-oauth"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"
  data = {
    "client-id"     = var.grafana_github_oauth_client_id_value
    "client-secret" = var.grafana_github_oauth_client_secret_value
  }
}

resource "kubernetes_secret" "letsencrypt_account_key" {
  lifecycle { ignore_changes = [metadata] }
  metadata {
    name      = "letsencrypt-account-key"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"
  data = {
    "tls.key" = var.letsencrypt_account_key_tls_key_value
  }
}

resource "kubernetes_secret" "letsencrypt_cert" {
  lifecycle { ignore_changes = [metadata] }
  metadata {
    name      = "letsencrypt-cert"
    namespace = var.kubernetes_namespace
    annotations = {
      "cert-manager.io/alt-names"        = "dev.afid.io,monitoring.dev.afid.io,rabbitmq.dev.afid.io"
      "cert-manager.io/certificate-name" = "letsencrypt-cert"
      "cert-manager.io/common-name"      = "dev.afid.io"
      "cert-manager.io/ip-sans"          = ""
      "cert-manager.io/issuer-group"     = "cert-manager.io"
      "cert-manager.io/issuer-kind"      = "Issuer"
      "cert-manager.io/issuer-name"      = "lestencrypt"
      "cert-manager.io/uri-sans"         = ""
    }
    labels = {
      "controller.cert-manager.io/fao" = "true"
    }
  }
  type = "kubernetes.io/tls"
  data = {
    "tls.crt" = base64encode(var.letsencrypt_cert_tls_crt_value)
    "tls.key" = base64encode(var.letsencrypt_cert_tls_key_value)
  }
}

resource "kubernetes_secret" "loki_bucket_creds" {
  lifecycle { ignore_changes = [metadata] }
  metadata {
    name      = "loki-bucket-creds"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"
  data = {
    "access-key" = var.loki_bucket_creds_access_key_value
    "secret-key" = var.loki_bucket_creds_secret_key_value
  }
}

resource "kubernetes_secret" "maxmind_licence_key" {
  lifecycle { ignore_changes = [metadata] }
  metadata {
    name      = "maxmind-licence-key"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"
  data = {
    key = var.maxmind_licence_key_value
  }
}

resource "kubernetes_secret" "oracle-db-pass" {
  lifecycle { ignore_changes = [metadata] }
  metadata {
    name      = "oracle-db-pass"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"
  data = {
    password = var.oracle_db_pass_value
  }

}
resource "kubernetes_secret" "oracle_docker_creds" {
  lifecycle { ignore_changes = [metadata] }
  metadata {
    name      = "oracle-docker-creds"
    namespace = var.kubernetes_namespace
  }
  type = "kubernetes.io/dockerconfigjson"
  data = {
    ".dockerconfigjson" = base64encode(jsonencode({
      auths = {
        "${var.oracle_docker_creds_registry_server_value}" = {
          username = var.oracle_docker_creds_username_value
          password = var.oracle_docker_creds_password_value
          email    = var.oracle_docker_creds_email_value
          auth     = base64encode("${var.oracle_docker_creds_username_value}:${var.oracle_docker_creds_password_value}")
        }
      }
    }))
  }
}

resource "kubernetes_secret" "postgres_auth" {
  lifecycle { ignore_changes = [metadata] }
  metadata {
    name      = "postgres-auth"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"
  data = {
    password            = var.postgres_auth_password_value
    "postgres-password" = var.postgres_auth_password_value
  }
}

resource "kubernetes_secret" "rabbitmq_auth" {
  lifecycle { ignore_changes = [metadata] }
  metadata {
    name      = "rabbitmq-auth"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"
  data = {
    "rabbitmq-erlang-cookie" = var.rabbitmq_auth_erlang_cookie_value
    "rabbitmq-password"      = var.rabbitmq_auth_password_value
  }
}


resource "kubernetes_secret" "s3_creds" {
  lifecycle { ignore_changes = [metadata] }
  metadata {
    name      = "s3-creds"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"
  data = {
    "access-key" = var.s3_creds_access_key_value
    "secret-key" = var.s3_creds_secret_key_value
  }
}

resource "kubernetes_secret" "stereolib_keys" {
  lifecycle { ignore_changes = [metadata] }
  metadata {
    name      = "stereolib-keys"
    namespace = var.kubernetes_namespace
  }
  type = "Opaque"
  data = {
    key1 = var.stereolib_keys_key1_value
    key2 = var.stereolib_keys_key2_value
  }
}

