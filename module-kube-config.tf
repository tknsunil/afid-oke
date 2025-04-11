# module-kube-config.tf

variable "kubeconfig_filename" {
  description = "Path and filename for the saved kubeconfig file."
  type        = string
}

data "oci_containerengine_cluster_kube_config" "oke_cluster_kube_config" {
  cluster_id = var.create_cluster ? one(module.cluster[*].cluster_id) : var.cluster_id
}

resource "local_file" "kube_config_file" {
  content         = data.oci_containerengine_cluster_kube_config.oke_cluster_kube_config.content
  filename        = pathexpand(var.kubeconfig_filename)
  file_permission = "0600"

  depends_on = [module.cluster[0].oci_containerengine_cluster]
}

# Add a delay after copying the kubeconfig file to ensure it's available
resource "time_sleep" "kubeconfig_setup" {
  depends_on      = [local_file.kube_config_file]
  create_duration = "60s"
}

output "kubeconfig_file_path" {
  description = "Path to the generated kubeconfig file for the OKE cluster."
  value       = resource.local_file.kube_config_file.filename
}

output "kubeconfig_dependency" {
  description = "Dependency to ensure kubeconfig is available with delay"
  value       = time_sleep.kubeconfig_setup
}
