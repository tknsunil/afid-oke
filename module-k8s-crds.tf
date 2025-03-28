module "kubernetes_crds" {
  source = "./modules/k8s-crds"

  depends_on = [
    resource.local_file.kube_config_file,
    module.cluster[0].oci_containerengine_cluster
  ]
}
