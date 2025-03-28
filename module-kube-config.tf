# module-kube-config.tf


variable "kubeconfig_filename" {
  description = "Path and filename for the saved kubeconfig file."
  type        = string
  default     = "./kubeconfig_oke_cluster"
}

data "oci_containerengine_cluster_kube_config" "oke_cluster_kube_config" {
  cluster_id = var.create_cluster ? one(module.cluster[*].cluster_id) : var.cluster_id
}


resource "local_file" "kube_config_file" {
  content         = data.oci_containerengine_cluster_kube_config.oke_cluster_kube_config.content
  filename        = var.kubeconfig_filename
  file_permission = "0600"

}

output "kubeconfig_file_path" {
  description = "Path to the generated kubeconfig file for the OKE cluster."
  value       = resource.local_file.kube_config_file.filename
}
