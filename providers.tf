provider "oci" {
  fingerprint      = var.api_fingerprint
  private_key_path = var.api_private_key_path
  region           = var.region
  tenancy_ocid     = var.tenancy_id
  user_ocid        = var.user_id
}

provider "oci" {
  fingerprint      = var.api_fingerprint
  private_key_path = var.api_private_key_path
  region           = var.home_region
  tenancy_ocid     = var.tenancy_id
  user_ocid        = var.user_id
  alias            = "home"
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_filename
  }
  registry {
    url      = "oci://ghcr.io/${var.registry_org}"
    username = var.registry_org
    password = var.github_token
  }

}

provider "kubernetes" {
  config_path = var.kubeconfig_filename
}
provider "http" {
  # Configuration options
}
