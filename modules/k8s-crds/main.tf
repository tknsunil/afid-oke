
# -----------------------------------------------------------------------------
# kube-prometheus-stack CRDs
# -----------------------------------------------------------------------------

resource "helm_release" "kube_prometheus_stack_crds" {
  name       = "kube-prometheus-stack-crds"
  chart      = "kube-prometheus-stack-crds"
  repository = "https://morremeyer.github.io/charts/"
  version    = "45.25.0"

  namespace = "kube-system"

  # Set to create namespace if it doesn't exist (optional)
  create_namespace = true

  # Prevent updates, as these CRDs are usually installed once and rarely changed
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
      wait_for_jobs
    ]
  }
}



resource "helm_release" "loki_crds" {
  name             = "loki-crds"
  chart            = "loki"
  repository       = "https://grafana.github.io/helm-charts"
  version          = "2.14.0"
  namespace        = "loki-crds-system"
  create_namespace = true

  set {
    name  = "crds.enabled"
    value = "true"
  }
  set {
    name  = "loki.enabled"
    value = "false"
  }
  set {
    name  = "promtail.enabled"
    value = "false"
  }
  set {
    name  = "grafana.enabled"
    value = "false"
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
      wait_for_jobs
    ]
  }
}

