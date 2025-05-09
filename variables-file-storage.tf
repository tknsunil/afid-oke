# File Storage variables
variable "create_file_storage" {
  description = "Whether to create the file storage resources"
  type        = bool
  default     = false
}

variable "file_storage_availability_domain" {
  description = "The availability domain for the file storage mount target. If not specified, the first AD will be used."
  type        = string
  default     = ""
}

variable "file_storage_subnet_id" {
  description = "The subnet ID for the file storage mount target. If not specified, the worker subnet will be used."
  type        = string
  default     = ""
}

variable "file_storage_mount_target_name" {
  description = "The display name for the file storage mount target"
  type        = string
  default     = "afid-file-mount-target"
}

variable "file_storage_hostname_label" {
  description = "The hostname label for the file storage mount target"
  type        = string
  default     = "afidfs"
}

variable "file_storage_nsg_ids" {
  description = "List of network security group IDs for the file storage mount target. If not specified, the worker NSG will be used."
  type        = list(string)
  default     = []
}

variable "file_storage_file_system_name" {
  description = "The display name for the file system"
  type        = string
  default     = "afid-file-system"
}

variable "create_storage_class" {
  description = "Whether to create a Kubernetes storage class for the file storage"
  type        = bool
  default     = true
}

variable "storage_class_name" {
  description = "The name of the Kubernetes storage class"
  type        = string
  default     = "oci-fss"
}

variable "storage_class_reclaim_policy" {
  description = "The reclaim policy for the Kubernetes storage class"
  type        = string
  default     = "Delete"
}

variable "create_file_storage_policy" {
  description = "Whether to create an IAM policy for the file storage"
  type        = bool
  default     = true
}
