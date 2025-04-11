# module-k8s-secrets.tf

module "kubernetes_s3_secrets" {
  source = "./modules/k8s-secrets"

  # Django S3 Secrets - Allow override, default to generated keys from object_storage module
  django_s3_access_key   = var.django_s3_access_key != "" ? var.django_s3_access_key : module.object_storage.bucket_access_key
  django_s3_secret_key   = var.django_s3_secret_key != "" ? var.django_s3_secret_key : module.object_storage.bucket_access_secret_key
  django_s3_endpoint_url = module.object_storage.object_storage_s3_endpoint
  django_s3_region       = module.object_storage.object_storage_region

  # Loki S3 Secrets - Allow override, default to generated keys from object_storage module
  loki_s3_access_key   = var.loki_s3_access_key != "" ? var.loki_s3_access_key : module.object_storage.bucket_access_key
  loki_s3_secret_key   = var.loki_s3_secret_key != "" ? var.loki_s3_secret_key : module.object_storage.bucket_access_secret_key
  loki_s3_endpoint_url = module.object_storage.object_storage_s3_endpoint
  loki_s3_region       = module.object_storage.object_storage_region

  # Tempo S3 Secrets - Allow override, default to generated keys from object_storage module
  tempo_s3_access_key   = var.tempo_s3_access_key != "" ? var.tempo_s3_access_key : module.object_storage.bucket_access_key
  tempo_s3_secret_key   = var.tempo_s3_secret_key != "" ? var.tempo_s3_secret_key : module.object_storage.bucket_access_secret_key
  tempo_s3_endpoint_url = module.object_storage.object_storage_s3_endpoint
  tempo_s3_region       = module.object_storage.object_storage_region

  # Database Credentials
  oracle_db_pass_value         = var.oracle_db_pass
  postgres_auth_password_value = var.postgres_auth_password

  # Message Broker Credentials
  rabbitmq_auth_password_value      = var.rabbitmq_auth_password
  rabbitmq_auth_erlang_cookie_value = var.rabbitmq_auth_erlang_cookie

  # Cloud & API Credentials
  cloudflare_api_token_value = var.cloudflare_api_token
  maxmind_licence_key_value  = var.maxmind_licence_key

  # Storage Credentials (S3, Loki, etc.)
  s3_creds_access_key_value          = coalesce(var.django_s3_access_key, var.s3_creds_access_key)
  s3_creds_secret_key_value          = coalesce(var.django_s3_secret_key, var.s3_creds_secret_key)
  loki_bucket_creds_access_key_value = coalesce(var.loki_s3_access_key, var.loki_bucket_creds_access_key)
  loki_bucket_creds_secret_key_value = coalesce(var.loki_s3_secret_key, var.loki_bucket_creds_secret_key)

  # Encryption & Security Keys
  django_secret_key_value               = var.django_secret_key
  letsencrypt_cert_tls_key_value        = var.letsencrypt_cert_tls_key
  letsencrypt_cert_tls_crt_value        = var.letsencrypt_cert_tls_crt
  letsencrypt_account_key_tls_key_value = var.letsencrypt_account_key_tls_key

  # Docker Credentials
  dockercred_email_value           = var.dockercred_email
  dockercred_username_value        = var.dockercred_username
  dockercred_password_value        = var.dockercred_password
  dockercred_registry_server_value = var.dockercred_registry_server

  # Oracle Container & Docker Credentials
  oracle_docker_creds_username_value        = var.oracle_docker_creds_username
  oracle_docker_creds_password_value        = var.oracle_docker_creds_password
  oracle_docker_creds_registry_server_value = var.oracle_docker_creds_registry_server

  # Django Application Credentials
  django_github_oauth_client_id_value     = var.django_github_oauth_client_id
  django_github_oauth_client_secret_value = var.django_github_oauth_client_secret
  django_superuser_username_value         = var.django_superuser_username
  django_superuser_password_value         = var.django_superuser_password
  django_superuser_email_value            = var.django_superuser_email

  # Grafana Authentication
  grafana_github_oauth_client_id_value     = var.grafana_github_oauth_client_id
  grafana_github_oauth_client_secret_value = var.grafana_github_oauth_client_secret

  # Email Credentials
  email_credentials_username = var.email_credentials_username
  email_credentials_password = var.email_credentials_password

  # Miscellaneous API Keys
  emtmlib_keys_key1_value   = var.emtmlib_keys_key1
  emtmlib_keys_key2_value   = var.emtmlib_keys_key2
  stereolib_keys_key1_value = var.stereolib_keys_key1
  stereolib_keys_key2_value = var.stereolib_keys_key2

  depends_on = [
    time_sleep.kubeconfig_setup,
  ]

}


variable "django_s3_access_key" {
  type        = string
  description = "Access key for Django S3 secrets."
  default     = ""

}

variable "django_s3_secret_key" {
  type        = string
  description = "Secret key for Django S3 secrets."
  default     = ""
}

variable "django_s3_endpoint_url" {
  type        = string
  description = "Endpoint URL for Django S3 secrets."
  default     = ""
}

variable "django_s3_region" {
  type        = string
  description = "(Optional) Region for Django S3 secrets."
  default     = ""
}

variable "loki_s3_access_key" {
  type        = string
  description = "Access key for Loki S3 secrets."
  default     = ""
}

variable "loki_s3_secret_key" {
  type        = string
  description = "Secret key for Loki S3 secrets."
  default     = ""
}

variable "loki_s3_endpoint_url" {
  type        = string
  description = "Endpoint URL for Loki S3 secrets."
  default     = ""
}

variable "loki_s3_region" {
  type        = string
  description = "(Optional) Region for Loki S3 secrets."
  default     = ""
}

variable "tempo_s3_access_key" {
  type        = string
  description = "Access key for Tempo S3 secrets."
  default     = ""
}

variable "tempo_s3_secret_key" {
  type        = string
  description = "Secret key for Tempo S3 secrets."
  default     = ""
}

variable "tempo_s3_endpoint_url" {
  type        = string
  description = "Endpoint URL for Tempo S3 secrets."
  default     = ""
}

variable "tempo_s3_region" {
  type        = string
  description = "(Optional) Region for Tempo S3 secrets."
  default     = ""
}


variable "emtmlib_keys_key1" {
  type        = string
  description = "emtmlib_keys_key1"
}
variable "emtmlib_keys_key2" {
  type        = string
  description = "emtmlib_keys_key2"
}
variable "loki_bucket_creds_access_key" {
  type        = string
  description = "loki_bucket_creds_access_key"
}
variable "oracle_docker_creds_password" {
  type        = string
  description = "oracle_docker_creds_password"
}
variable "django_github_oauth_client_secret" {
  type        = string
  description = "django_github_oauth_client_secret"
}

variable "django_superuser_username" {
  type        = string
  description = "django_superuser_username"
}
variable "s3_creds_access_key" {
  type        = string
  description = "s3_creds_access_key"
}
variable "stereolib_keys_key1" {
  type        = string
  description = "stereolib_keys_key1"
}
variable "django_github_oauth_client_id" {
  type        = string
  description = "django_github_oauth_client_id"
}
variable "oracle_db_pass" {
  type        = string
  description = "oracle_db_pass"
}
variable "postgres_auth_password" {
  type        = string
  description = "postgres_auth_password"
}
variable "rabbitmq_auth_password" {
  type        = string
  description = "rabbitmq_auth_password"
}
variable "grafana_github_oauth_client_secret" {
  type        = string
  description = "grafana_github_oauth_client_secret"
}
variable "loki_bucket_creds_secret_key" {
  type        = string
  description = "loki_bucket_creds_secret_key"
}
variable "django_superuser_password" {
  type        = string
  description = "django_superuser_password"
}
variable "letsencrypt_cert_tls_key" {
  type        = string
  description = "letsencrypt_cert_tls_key"
}
variable "dockercred_email" {
  type        = string
  description = "dockercred_email"
}
variable "dockercred_password" {
  type        = string
  description = "dockercred_password"
}
variable "rabbitmq_auth_erlang_cookie" {
  type        = string
  description = "rabbitmq_auth_erlang_cookie"
}

variable "oracle_docker_creds_username" {
  type        = string
  description = "oracle_docker_creds_username"
}
variable "s3_creds_secret_key" {
  type        = string
  description = "s3_creds_secret_key"
}
variable "letsencrypt_account_key_tls_key" {
  type        = string
  description = "letsencrypt_account_key_tls_key"
}
variable "oracle_docker_creds_registry_server" {
  type        = string
  description = "oracle_docker_creds_registry_server"
}

variable "cloudflare_api_token" {
  type        = string
  description = "cloudflare_api_token"
}
variable "django_superuser_email" {
  type        = string
  description = "django_superuser_email"
}
variable "letsencrypt_cert_tls_crt" {
  type        = string
  description = "letsencrypt_cert_tls_crt"
}
variable "dockercred_registry_server" {
  type        = string
  description = "dockercred_registry_server"
}
variable "grafana_github_oauth_client_id" {
  type        = string
  description = "grafana_github_oauth_client_id"
}
variable "maxmind_licence_key" {
  type        = string
  description = "maxmind_licence_key"
}
variable "stereolib_keys_key2" {
  type        = string
  description = "stereolib_keys_key2"
}
variable "django_secret_key" {
  type        = string
  description = "django_secret_key"
}

variable "dockercred_username" {
  type        = string
  description = "dockercred_username"
}

variable "email_credentials_username" {
  type        = string
  description = "email_credentials_username"
}
variable "email_credentials_password" {
  type        = string
  description = "email_credentials_password"
}
