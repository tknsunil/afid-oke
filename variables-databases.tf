# Oracle DB variables
variable "oracle_db_enabled" {
  description = "Whether to deploy Oracle DB"
  type        = bool
  default     = false
}

variable "oracle_db_availability_domain" {
  description = "The availability domain where the database will be created"
  type        = string
  default     = ""
}

variable "oracle_db_subnet_id" {
  description = "The OCID of the subnet where the database will be created"
  type        = string
  default     = ""
}

variable "oracle_db_name" {
  description = "The name of the database"
  type        = string
  default     = "ORCL"
}

variable "oracle_db_display_name" {
  description = "The display name of the database"
  type        = string
  default     = "OracleDB"
}

variable "oracle_db_admin_password" {
  description = "The password for the database admin user"
  type        = string
  sensitive   = true
  default     = ""
}

variable "oracle_db_version" {
  description = "The version of the database"
  type        = string
  default     = "19.0.0.0"
}

variable "oracle_db_edition" {
  description = "The edition of the database (STANDARD_EDITION, ENTERPRISE_EDITION, ENTERPRISE_EDITION_HIGH_PERFORMANCE, ENTERPRISE_EDITION_EXTREME_PERFORMANCE)"
  type        = string
  default     = "STANDARD_EDITION"
}

variable "oracle_db_license_model" {
  description = "The license model for the database (LICENSE_INCLUDED, BRING_YOUR_OWN_LICENSE)"
  type        = string
  default     = "LICENSE_INCLUDED"
}

variable "oracle_db_shape" {
  description = "The shape of the database. If not specified, a shape will be selected based on the environment."
  type        = string
  default     = ""
}

variable "oracle_db_storage_size_in_gb" {
  description = "The storage size for the database in GB"
  type        = number
  default     = 256
}

variable "oracle_db_storage_management" {
  description = "The storage management option for the database (ASM, LVM)"
  type        = string
  default     = "ASM"
}

variable "oracle_db_character_set" {
  description = "The character set for the database"
  type        = string
  default     = "AL32UTF8"
}

variable "oracle_db_ncharacter_set" {
  description = "The national character set for the database"
  type        = string
  default     = "AL16UTF16"
}

variable "oracle_db_pdb_name" {
  description = "The name of the pluggable database"
  type        = string
  default     = "PDB1"
}

variable "oracle_db_workload" {
  description = "The workload type of the database (OLTP, DSS)"
  type        = string
  default     = "OLTP"
}

variable "oracle_db_backup_subnet_id" {
  description = "The OCID of the subnet for database backups"
  type        = string
  default     = ""
}

variable "oracle_db_backup_enabled" {
  description = "Whether to enable automatic backups"
  type        = bool
  default     = true
}

variable "oracle_db_backup_retention_days" {
  description = "The number of days to retain automatic backups"
  type        = number
  default     = 7
}

variable "oracle_db_auto_backup_window" {
  description = "The backup window for automatic backups (SLOT_ONE, SLOT_TWO, SLOT_THREE, ...)"
  type        = string
  default     = "SLOT_TWO"
}

variable "oracle_db_recovery_window_in_days" {
  description = "The number of days for the recovery window"
  type        = number
  default     = 7
}

variable "oracle_db_hostname" {
  description = "The hostname for the database system"
  type        = string
  default     = "oracledb"
}

variable "oracle_db_domain" {
  description = "The domain name for the database system"
  type        = string
  default     = "example.com"
}

variable "oracle_db_node_count" {
  description = "The number of database nodes (for RAC)"
  type        = number
  default     = 1
}

variable "oracle_db_time_zone" {
  description = "The time zone for the database"
  type        = string
  default     = "UTC"
}

variable "oracle_db_auto_scaling_enabled" {
  description = "Whether to enable auto scaling for the database"
  type        = bool
  default     = false
}

variable "oracle_db_is_free_tier" {
  description = "Whether to use the Always Free resources"
  type        = bool
  default     = false
}

variable "oracle_db_private_endpoint_label" {
  description = "The private endpoint label for the database"
  type        = string
  default     = "dbprivate"
}

variable "oracle_db_defined_tags" {
  description = "Defined tags for the database"
  type        = map(string)
  default     = {}
}

variable "oracle_db_freeform_tags" {
  description = "Freeform tags for the database"
  type        = map(string)
  default     = {}
}

# PostgreSQL variables
variable "postgres_db_enabled" {
  description = "Whether to deploy PostgreSQL"
  type        = bool
  default     = false
}

variable "postgres_db_namespace" {
  description = "Kubernetes namespace for PostgreSQL"
  type        = string
  default     = "postgres-db"
}

variable "postgres_db_create_namespace" {
  description = "Whether to create the namespace for PostgreSQL"
  type        = bool
  default     = true
}

variable "postgres_db_storage_class" {
  description = "Storage class for PostgreSQL PVCs"
  type        = string
  default     = "oci-bv"
}

variable "postgres_db_pvc_size" {
  description = "Size of the PVC for PostgreSQL"
  type        = string
  default     = "8Gi"
}

variable "postgres_db_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "15.3.0"
}

variable "postgres_db_password" {
  description = "Password for the PostgreSQL admin user"
  type        = string
  sensitive   = true
  default     = ""
}

variable "postgres_db_username" {
  description = "Username for the PostgreSQL admin user"
  type        = string
  default     = "postgres"
}

variable "postgres_db_database" {
  description = "Name of the default PostgreSQL database"
  type        = string
  default     = "postgres"
}

variable "postgres_db_port" {
  description = "Port for PostgreSQL"
  type        = number
  default     = 5432
}

variable "postgres_db_memory_limit" {
  description = "Memory limit for PostgreSQL container"
  type        = string
  default     = "2Gi"
}

variable "postgres_db_cpu_limit" {
  description = "CPU limit for PostgreSQL container"
  type        = string
  default     = "1"
}

variable "postgres_db_memory_request" {
  description = "Memory request for PostgreSQL container"
  type        = string
  default     = "1Gi"
}

variable "postgres_db_cpu_request" {
  description = "CPU request for PostgreSQL container"
  type        = string
  default     = "500m"
}

variable "postgres_db_ha_enabled" {
  description = "Whether to enable high availability for PostgreSQL"
  type        = bool
  default     = false
}

variable "postgres_db_replicas" {
  description = "Number of PostgreSQL replicas when HA is enabled"
  type        = number
  default     = 2
}

variable "postgres_db_metrics_enabled" {
  description = "Whether to enable metrics for PostgreSQL"
  type        = bool
  default     = true
}

variable "postgres_db_service_type" {
  description = "Kubernetes service type for PostgreSQL"
  type        = string
  default     = "ClusterIP"
}

variable "postgres_db_persistence_enabled" {
  description = "Whether to enable persistence for PostgreSQL"
  type        = bool
  default     = true
}

variable "postgres_db_backup_enabled" {
  description = "Whether to enable backups for PostgreSQL"
  type        = bool
  default     = false
}

variable "postgres_db_backup_schedule" {
  description = "Cron schedule for PostgreSQL backups"
  type        = string
  default     = "0 0 * * *"
}

variable "postgres_db_backup_storage_class" {
  description = "Storage class for PostgreSQL backups"
  type        = string
  default     = "oci-bv"
}

variable "postgres_db_backup_size" {
  description = "Size of the PVC for PostgreSQL backups"
  type        = string
  default     = "8Gi"
}
