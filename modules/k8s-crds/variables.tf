# modules/k8s-crds/variables.tf

variable "cert_manager_namespace" {
  description = "Kubernetes namespace for cert-manager"
  type        = string
}

variable "cert_manager_helm_version" {
  description = "Helm chart version for cert-manager"
  type        = string
}

variable "letsencrypt_email" {
  description = "Email address for Let's Encrypt certificate notifications"
  type        = string
}

variable "letsencrypt_server" {
  description = "Let's Encrypt server URL (use staging for testing)"
  type        = string
}

variable "kubeconfig_dependency" {
  description = "Dependency to ensure kubeconfig is available"
  type        = any
}
