

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
    name  = "crds.enabled"
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
          name = "letsencrypt-account-key"
        }
        solvers = [
          {
            dns01 = {
              cloudflare = {
                apiTokenSecretRef = {
                  name = "cloudflare-api-token"
                  key  = "token"
                }
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
