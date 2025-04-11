# File Storage Mount Target for OKE
resource "oci_file_storage_mount_target" "afid_file_mount_target" {
  count               = var.create_file_storage ? 1 : 0
  compartment_id      = var.compartment_id
  availability_domain = var.file_storage_availability_domain != "" ? var.file_storage_availability_domain : lookup(local.ad_numbers_to_names, local.ad_numbers[0])
  subnet_id           = var.file_storage_subnet_id != "" ? var.file_storage_subnet_id : module.network.worker_subnet_id
  display_name        = var.file_storage_mount_target_name
  nsg_ids             = var.file_storage_nsg_ids != [] ? var.file_storage_nsg_ids : [module.network.worker_nsg_id]

  # Use the worker subnet's security list by default
  hostname_label = var.file_storage_hostname_label

  lifecycle {
    ignore_changes = [
      defined_tags, freeform_tags
    ]
  }
}

# Export the mount target details for use in Kubernetes storage class
resource "oci_file_storage_export_set" "afid_export_set" {
  count           = var.create_file_storage ? 1 : 0
  mount_target_id = oci_file_storage_mount_target.afid_file_mount_target[0].id
}

# Create a file system
resource "oci_file_storage_file_system" "afid_file_system" {
  count               = var.create_file_storage ? 1 : 0
  compartment_id      = var.compartment_id
  availability_domain = var.file_storage_availability_domain != "" ? var.file_storage_availability_domain : lookup(local.ad_numbers_to_names, local.ad_numbers[0])
  display_name        = var.file_storage_file_system_name

  lifecycle {
    ignore_changes = [
      defined_tags, freeform_tags
    ]
  }
}

# Create an export for the file system
resource "oci_file_storage_export" "afid_export" {
  count          = var.create_file_storage ? 1 : 0
  export_set_id  = oci_file_storage_export_set.afid_export_set[0].id
  file_system_id = oci_file_storage_file_system.afid_file_system[0].id
  path           = var.file_storage_export_path

  export_options {
    source                         = var.file_storage_export_source
    access                         = var.file_storage_export_access
    identity_squash                = var.file_storage_export_identity_squash
    require_privileged_source_port = var.file_storage_export_require_privileged_source_port
  }
}

# Create a Kubernetes storage class for the file storage
resource "kubernetes_storage_class" "oci_fss_storage_class" {
  count = var.create_file_storage && var.create_storage_class ? 1 : 0

  metadata {
    name = var.storage_class_name
  }

  storage_provisioner = "fss.csi.oraclecloud.com"
  reclaim_policy      = var.storage_class_reclaim_policy
  parameters = {
    availabilityDomain        = var.file_storage_availability_domain != "" ? var.file_storage_availability_domain : lookup(local.ad_numbers_to_names, local.ad_numbers[0])
    mountTargetOcid           = oci_file_storage_mount_target.afid_file_mount_target[0].id
    subnetOcid                = var.file_storage_subnet_id != "" ? var.file_storage_subnet_id : module.network.worker_subnet_id
    mntTargetPrivateIpAddress = oci_file_storage_mount_target.afid_file_mount_target[0].private_ip_ids[0]
  }

  depends_on = [
    oci_file_storage_mount_target.afid_file_mount_target,
    oci_file_storage_export.afid_export,
    time_sleep.kubeconfig_setup
  ]


}

# File Storage IAM Policies
resource "oci_identity_policy" "file_storage_policy" {
  count          = var.create_file_storage && var.create_file_storage_policy ? 1 : 0
  name           = "oke-file-storage-policy-${local.state_id}"
  description    = "Policy allowing OKE cluster to manage File Storage resources"
  compartment_id = var.compartment_id

  statements = [
    "ALLOW any-user to manage file-family in compartment id ${var.compartment_id} where request.principal.type = 'cluster'",
    "ALLOW any-user to use virtual-network-family in compartment id ${var.compartment_id} where request.principal.type = 'cluster'"
  ]

  # Use the same tags as other IAM resources
  defined_tags  = local.iam_defined_tags
  freeform_tags = local.iam_freeform_tags
}


# Output the mount target OCID for use in storage class
output "file_storage_mount_target_id" {
  description = "The OCID of the file storage mount target"
  value       = var.create_file_storage ? oci_file_storage_mount_target.afid_file_mount_target[0].id : null
}

output "file_storage_mount_target_private_ip" {
  description = "The private IP address of the file storage mount target"
  value       = var.create_file_storage ? oci_file_storage_mount_target.afid_file_mount_target[0].private_ip_ids[0] : null
}

output "file_storage_file_system_id" {
  description = "The OCID of the file system"
  value       = var.create_file_storage ? oci_file_storage_file_system.afid_file_system[0].id : null
}

output "storage_class_name" {
  description = "The name of the created Kubernetes storage class"
  value       = var.create_file_storage && var.create_storage_class ? kubernetes_storage_class.oci_fss_storage_class[0].metadata[0].name : null
}
