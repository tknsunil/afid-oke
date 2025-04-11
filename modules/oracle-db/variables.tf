

variable "compartment_id" {
  description = "The OCID of the compartment where the database will be created"
  type        = string
}

variable "subnet_id" {
  description = "The OCID of the subnet where the database will be created"
  type        = string
}

variable "environment" {
  description = "Environment (dev, test, prod)"
  type        = string
  default     = "dev"
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "ORCL"
}

variable "db_display_name" {
  description = "The display name of the database"
  type        = string
  default     = "AFIDOracleDatabase"
}

variable "db_admin_password" {
  description = "The password for the database admin user"
  type        = string
  sensitive   = true
}

variable "db_version" {
  description = "The version of the database"
  type        = string
  default     = "19.0.0.0"
}

variable "db_edition" {
  description = "The edition of the database (STANDARD_EDITION, ENTERPRISE_EDITION, ENTERPRISE_EDITION_HIGH_PERFORMANCE, ENTERPRISE_EDITION_EXTREME_PERFORMANCE)"
  type        = string
  default     = "STANDARD_EDITION"
  validation {
    condition     = contains(["STANDARD_EDITION", "ENTERPRISE_EDITION", "ENTERPRISE_EDITION_HIGH_PERFORMANCE", "ENTERPRISE_EDITION_EXTREME_PERFORMANCE"], var.db_edition)
    error_message = "DB edition must be one of: STANDARD_EDITION, ENTERPRISE_EDITION, ENTERPRISE_EDITION_HIGH_PERFORMANCE, ENTERPRISE_EDITION_EXTREME_PERFORMANCE."
  }
}

variable "db_shape" {
  description = "The shape of the database. If not specified, a shape will be selected based on the environment."
  type        = string
  default     = "VM.Standard.E4.Flex"
}

variable "db_storage_size_in_gb" {
  description = "The storage size for the database in GB"
  type        = number
  default     = 256
}

variable "db_character_set" {
  description = "The character set for the database"
  type        = string
  default     = "AL32UTF8"
}

variable "db_ncharacter_set" {
  description = "The national character set for the database"
  type        = string
  default     = "AL16UTF16"
}

variable "db_pdb_name" {
  description = "The name of the pluggable database"
  type        = string
  default     = "PDB1"
}

variable "db_workload" {
  description = "The workload type of the database (OLTP, DSS)"
  type        = string
  default     = "OLTP"
  validation {
    condition     = contains(["OLTP", "DSS"], var.db_workload)
    error_message = "Workload must be one of: OLTP, DSS."
  }
}


variable "db_backup_enabled" {
  description = "Whether to enable automatic backups"
  type        = bool
  default     = false
}

variable "db_backup_retention_days" {
  description = "The number of days to retain automatic backups"
  type        = number
  default     = 7
}

variable "db_auto_backup_window" {
  description = "The backup window for automatic backups (SLOT_ONE, SLOT_TWO, SLOT_THREE, ...)"
  type        = string
  default     = "SLOT_TWO"
}

variable "db_recovery_window_in_days" {
  description = "The number of days for the recovery window"
  type        = number
  default     = 7
}

variable "db_hostname" {
  description = "The hostname for the database system"
  type        = string
  default     = "oracledb"
}


variable "db_node_count" {
  description = "The number of database nodes (for RAC)"
  type        = number
  default     = 1
}

variable "db_time_zone" {
  description = "The time zone for the database"
  type        = string
  default     = "UTC"
}

variable "db_is_free_tier" {
  description = "Whether to use the Always Free resources"
  type        = bool
  default     = true
}

variable "ssh_public_key_path" {
  description = "The path to the SSH public key file"
  type        = string
}


variable "db_defined_tags" {
  description = "Defined tags for the database"
  type        = map(string)
  default     = {}
}

variable "db_freeform_tags" {
  description = "Freeform tags for the database"
  type        = map(string)
  default     = {}
}
