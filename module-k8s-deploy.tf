
module "helm_afid_apps" {
  count  = 0 # disable deploying from here for now
  source = "./modules/k8s-deploy"

  environment = var.environment
  core_tag    = var.core_tag
  nextjs_tag  = var.nextjs_tag

  kubernetes_namespace = var.kubernetes_namespace
  registry_org         = var.registry_org


  github_token = var.github_token

  # Ensure Helm charts are deployed only after cluster and post-oke setup are complete
  depends_on = [
    module.kubernetes_s3_secrets,
    module.kubernetes_crds,
  ]
}

variable "environment" {
  type = string
}
variable "core_tag" {
  type    = string
  default = "latest"
}
variable "nextjs_tag" {
  type    = string
  default = "latest"
}
variable "kubernetes_namespace" {
  type    = string
  default = "default"
}
variable "github_token" {
  type        = string
  default     = ""
  sensitive   = true
  description = "GitHub PAT if afid-deploy repo is private."
}


variable "registry_org" {
  type        = string
  description = "The base URL of the Git repository containing the Helm charts."
  default     = "afid"

}
