module "kubernetes_s3_secrets" {
  source = "./modules/k8s-secrets"

  django_s3_access_key   = ""
  django_s3_secret_key   = ""
  django_s3_endpoint_url = ""
  django_s3_region       = ""

  loki_s3_access_key   = ""
  loki_s3_secret_key   = ""
  loki_s3_endpoint_url = ""
  loki_s3_region       = ""

  tempo_s3_access_key   = ""
  tempo_s3_secret_key   = ""
  tempo_s3_endpoint_url = ""
  tempo_s3_region       = ""


}
