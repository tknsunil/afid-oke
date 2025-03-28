# modules/helm-afid-apps/variables.tf

variable "environment" {
  type        = string
  description = "The deployment environment (e.g., 'dev', 'staging', 'prod'), used to select values files."
  default     = "dev"
}

variable "core_tag" {
  type        = string
  description = "The Docker image tag for the 'django' component."
  default     = "latest"
}

variable "nextjs_tag" {
  type        = string
  description = "The Docker image tag for the 'nextjs' component."
  default     = "latest"
}

variable "kubernetes_namespace" {
  type        = string
  description = "The Kubernetes namespace to deploy the Helm charts into."
  default     = "default"
}

variable "git_repo_url" {
  type        = string
  description = "The base URL of the Git repository containing the Helm charts."
  default     = "github.com/AutomatedFishID/afid-deploy"
}

variable "git_ref" {
  type        = string
  description = "The Git reference (branch, tag, or commit SHA) to check out for the Helm charts."
  default     = "dev"
}

variable "github_token" {
  type        = string
  description = "(Optional) A GitHub Personal Access Token (PAT) with read access if the repository is private. Needed to fetch values files."
  default     = ""
  sensitive   = true
}

variable "helm_timeout_seconds" {
  type        = number
  description = "Timeout in seconds for Helm operations."
  default     = 600 # 10 minutes
}

variable "registry_org" {
  type        = string
  description = "The base URL of the Git repository containing the Helm charts."
  default     = "afid"

}
