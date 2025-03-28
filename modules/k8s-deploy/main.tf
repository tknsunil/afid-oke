
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
  name                = "afid"
  namespace           = var.kubernetes_namespace
  chart               = "oci://ghcr.io/${var.registry_org}/afid/afid-core"
  version             = "0.0.1"
  repository_username = var.github_token
  repository_password = var.github_token
  timeout             = var.helm_timeout_seconds
  atomic              = true
  cleanup_on_fail     = true
  lint                = true

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
  lifecycle {
    ignore_changes = [
      values,
      set,
      set_sensitive,
      force_update,
      recreate_pods,
      wait,
      timeout,
      disable_crd_hooks,
      disable_webhooks,
      skip_crds,
      render_subchart_notes,
      verify,
      keyring,
      atomic,
      cleanup_on_fail,
      max_history,
      dependency_update,
      replace,
      reset_values,
      reuse_values,
      wait_for_jobs,
    ]
  }

}

resource "helm_release" "afid_detectors_app" {
  name                = "afid-detectors"
  namespace           = var.kubernetes_namespace
  chart               = "oci://ghcr.io/${var.registry_org}/afid-detectors/afid-detectors"
  version             = "0.0.1"
  repository_username = var.github_token
  repository_password = var.github_token
  timeout             = var.helm_timeout_seconds
  atomic              = true
  cleanup_on_fail     = true
  lint                = true

  values = [
    data.http.afid_detectors_values_content.response_body
  ]
  lifecycle {
    ignore_changes = [
      values,
      set,
      set_sensitive,
      force_update,
      recreate_pods,
      wait,
      timeout,
      disable_crd_hooks,
      disable_webhooks,
      skip_crds,
      render_subchart_notes,
      verify,
      keyring,
      atomic,
      cleanup_on_fail,
      max_history,
      dependency_update,
      replace,
      reset_values,
      reuse_values,
      wait_for_jobs,
    ]
  }
}
