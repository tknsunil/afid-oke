
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

resource "helm_release" "grafana_agent_crds" {
  name             = "grafana-agent-crds"
  chart            = "grafana-agent"
  repository       = "https://grafana.github.io/helm-charts"
  version          = "0.2.3"
  namespace        = "monitoring" # Adjust namespace as needed
  create_namespace = true

  # Set controller.replicas to 0 to avoid deploying any pods
  set {
    name  = "controller.replicas"
    value = "0"
  }

  # If the chart installs CRDs conditionally, ensure CRDs are enabled.
  # This may be needed if the chart has a flag like "crds.enabled".
  set {
    name  = "crds.enabled"
    value = "true"
  }

  # Optionally, disable other components if they are not required:
  set {
    name  = "agent.enabled"
    value = "false"
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
      wait_for_jobs,
    ]
  }
}


resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  chart            = "cert-manager"
  repository       = "https://charts.jetstack.io"
  version          = var.cert_manager_helm_version
  namespace        = var.cert_manager_namespace
  timeout          = 600
  atomic           = true
  cleanup_on_fail  = true
  lint             = true
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
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

  depends_on = [
    var.kubeconfig_dependency
  ]
}

# Create a ClusterIssuer for Let's Encrypt
resource "kubernetes_manifest" "letsencrypt_cluster_issuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "letsencrypt-prod"
    }
    spec = {
      acme = {
        server = var.letsencrypt_server
        email  = var.letsencrypt_email
        privateKeySecretRef = {
          name = "letsencrypt-prod-account-key"
        }
        solvers = [
          {
            http01 = {
              ingress = {
                class = "nginx"
              }
            }
          }
        ]
      }
    }
  }

  depends_on = [
    helm_release.cert_manager,
    time_sleep.wait_for_cert_manager
  ]
}

# Wait for cert-manager to be ready before creating the ClusterIssuer
resource "time_sleep" "wait_for_cert_manager" {
  depends_on      = [helm_release.cert_manager]
  create_duration = "30s"
}
