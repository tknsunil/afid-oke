variable "django_s3_access_key" {
  type        = string
  description = "Access key for Django S3 secrets."
}

variable "django_s3_secret_key" {
  type        = string
  description = "Secret key for Django S3 secrets."
}

variable "django_s3_endpoint_url" {
  type        = string
  description = "Endpoint URL for Django S3 secrets."
}

variable "django_s3_region" {
  type        = string
  description = "(Optional) Region for Django S3 secrets."
  default     = ""
}

variable "email_credentials_username" {
  type        = string
  description = "Username for email credentials."
}

variable "email_credentials_password" {
  type        = string
  description = "Password for email credentials."
}
variable "loki_s3_access_key" {
  type        = string
  description = "Access key for Loki S3 secrets."
}

variable "loki_s3_secret_key" {
  type        = string
  description = "Secret key for Loki S3 secrets."
}

variable "loki_s3_endpoint_url" {
  type        = string
  description = "Endpoint URL for Loki S3 secrets."
}

variable "loki_s3_region" {
  type        = string
  description = "(Optional) Region for Loki S3 secrets."
  default     = ""
}

variable "tempo_s3_access_key" {
  type        = string
  description = "Access key for Tempo S3 secrets."
}

variable "tempo_s3_secret_key" {
  type        = string
  description = "Secret key for Tempo S3 secrets."
}

variable "tempo_s3_endpoint_url" {
  type        = string
  description = "Endpoint URL for Tempo S3 secrets."
}

variable "tempo_s3_region" {
  type        = string
  description = "(Optional) Region for Tempo S3 secrets."
  default     = ""
}

variable "kubernetes_namespace" {
  type        = string
  description = "Kubernetes namespace where secrets will be created."
  default     = "default"
}

variable "cloudflare_api_token_value" {
  type        = string
  description = "The plain text API token for Cloudflare."
  sensitive   = true

}

variable "django_github_oauth_client_id_value" {
  type        = string
  sensitive   = true
  description = "Plain text client ID for Django GitHub OAuth."
}
variable "django_github_oauth_client_secret_value" {
  type        = string
  sensitive   = true
  description = "Plain text client secret for Django GitHub OAuth."
}



variable "django_secret_key_value" {
  type        = string
  sensitive   = true
  description = "Plain text Django secret key."
}

variable "django_superuser_email_value" {
  type        = string
  sensitive   = true
  description = "Plain text email for Django superuser."
}



variable "django_superuser_password_value" {
  type        = string
  sensitive   = true
  description = "Plain text password for Django superuser."
}

variable "django_superuser_username_value" {
  type        = string
  sensitive   = true
  description = "Plain text username for Django superuser."
  default     = "afid"
}

variable "dockercred_registry_server_value" {
  type        = string
  sensitive   = true
  description = "Docker registry server for 'dockercred' (e.g., docker.io, ghcr.io)."
  default     = "docker.io"
}

variable "dockercred_username_value" {
  type        = string
  sensitive   = true
  description = "Plain text username for 'dockercred'."
}

variable "dockercred_password_value" {
  type        = string
  sensitive   = true
  description = "Plain text password/token for 'dockercred'."
}

variable "dockercred_email_value" {
  type        = string
  sensitive   = true
  description = "Email for 'dockercred' (optional)."
  default     = "" # Often optional
}

variable "emtmlib_keys_key1_value" {
  type        = string
  sensitive   = true
  description = "Plain text value for emtmlib key1."
  default     = "XXXXXXXXXX"

}

variable "emtmlib_keys_key2_value" {
  type        = string
  sensitive   = true
  description = "Plain text value for emtmlib key2."
  default     = "XXXXXXXXXX"
}

variable "grafana_github_oauth_client_id_value" {
  type        = string
  sensitive   = true
  description = "Plain text client ID for Grafana GitHub OAuth."
}

variable "grafana_github_oauth_client_secret_value" {
  type        = string
  sensitive   = true
  description = "Plain text client secret for Grafana GitHub OAuth."
}


variable "letsencrypt_account_key_tls_key_value" {
  type        = string
  sensitive   = true
  description = "Plain text private key (PEM format) for LetsEncrypt account."
}


variable "letsencrypt_cert_tls_crt_value" {
  type        = string
  sensitive   = true
  description = "Plain text certificate content (PEM format) for letsencrypt-cert."
}
variable "letsencrypt_cert_tls_key_value" {
  type        = string
  sensitive   = true
  description = "Plain text private key content (PEM format) for letsencrypt-cert."
}


variable "loki_bucket_creds_access_key_value" {
  type        = string
  sensitive   = true
  description = "Plain text access key for Loki bucket."
}
variable "loki_bucket_creds_secret_key_value" {
  type        = string
  sensitive   = true
  description = "Plain text secret key for Loki bucket."
}


variable "maxmind_licence_key_value" {
  type        = string
  sensitive   = true
  description = "Plain text MaxMind license key."
}



variable "oracle_db_pass_value" {
  type        = string
  sensitive   = true
  description = "Plain text Oracle DB password."

}

variable "oracle_docker_creds_registry_server_value" {
  type        = string
  sensitive   = true
  description = "Registry server for 'oracle-docker-creds' (e.g., docker.io)."
}
variable "oracle_docker_creds_username_value" {
  type        = string
  sensitive   = true
  description = "Plain text username for 'oracle-docker-creds'."
}
variable "oracle_docker_creds_password_value" {
  type        = string
  sensitive   = true
  description = "Plain text password/token for 'oracle-docker-creds'."
}
variable "oracle_docker_creds_email_value" {
  type        = string
  sensitive   = true
  description = "Email for 'oracle-docker-creds' (optional)."
  default     = ""
}

variable "postgres_auth_password_value" {
  type        = string
  sensitive   = true
  description = "Plain text general password for postgres-auth."
}

variable "rabbitmq_auth_erlang_cookie_value" {
  type        = string
  sensitive   = true
  description = "Plain text RabbitMQ Erlang cookie."
}
variable "rabbitmq_auth_password_value" {
  type        = string
  sensitive   = true
  description = "Plain text RabbitMQ password."
}


variable "s3_creds_access_key_value" {
  type        = string
  sensitive   = true
  description = "Plain text access key for s3-creds."
}
variable "s3_creds_secret_key_value" {
  type        = string
  sensitive   = true
  description = "Plain text secret key for s3-creds."
}


variable "stereolib_keys_key1_value" {
  type        = string
  sensitive   = true
  description = "Plain text value for stereolib key1."
  default     = "XXXXXXXXXX"
}
variable "stereolib_keys_key2_value" {
  type        = string
  sensitive   = true
  description = "Plain text value for stereolib key2."
  default     = "XXXXXXXXXX"
}


variable "app_subdomain" {
  type        = string
  description = "The subdomain for the application"
}
