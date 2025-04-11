module "kubernetes_crds" {
  count  = 0
  source = "./modules/k8s-crds"

  cert_manager_namespace    = var.cert_manager_namespace
  cert_manager_helm_version = var.cert_manager_helm_version
  letsencrypt_email         = var.letsencrypt_email
  letsencrypt_server        = var.letsencrypt_server
  kubeconfig_dependency     = time_sleep.kubeconfig_setup

  depends_on = [
    resource.local_file.kube_config_file,
    module.cluster[0].oci_containerengine_cluster
  ]
}
