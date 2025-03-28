
data "http" "afid_values_content" {

  url = "https://raw.githubusercontent.com/${var.git_repo_url}/${var.git_ref}/helm-charts/afid/values/${var.environment}.yaml"

  request_headers = var.github_token != "" ? {
    Authorization = "token ${var.github_token}"
    Accept        = "application/vnd.github.v3.raw"
    } : {
    Accept = "application/vnd.github.v3.raw"
  }

  # Optional: Add retry logic if fetching sometimes fails
  retry {
    attempts     = 3
    min_delay_ms = 1000
  }
}

data "http" "afid_detectors_values_content" {
  url = "https://raw.githubusercontent.com/${var.git_repo_url}/${var.git_ref}/helm-charts/afid-detectors/values/${var.environment}.yaml"

  request_headers = var.github_token != "" ? {
    Authorization = "token ${var.github_token}"
    Accept        = "application/vnd.github.v3.raw"
    } : {
    Accept = "application/vnd.github.v3.raw"
  }
}

resource "helm_release" "afid_app" {
  name            = "afid"
  namespace       = var.kubernetes_namespace
  chart           = "git+https://${var.git_repo_url}.git?ref=${var.git_ref}&path=helm-charts/afid"
  timeout         = var.helm_timeout_seconds
  atomic          = true
  cleanup_on_fail = true
  lint            = true

  values = [
    data.http.afid_values_content.response_body
  ]

  set {
    name  = "django.image.tag"
    value = var.core_tag
  }
  set {
    name  = "nextjs.image.tag"
    value = var.nextjs_tag
  }

}

resource "helm_release" "afid_detectors_app" {
  name            = "afid-detectors"
  namespace       = var.kubernetes_namespace
  chart           = "git+https://${var.git_repo_url}.git?ref=${var.git_ref}&path=helm-charts/afid-detectors"
  timeout         = var.helm_timeout_seconds
  atomic          = true
  cleanup_on_fail = true
  lint            = true

  values = [
    data.http.afid_detectors_values_content.response_body
  ]

}
