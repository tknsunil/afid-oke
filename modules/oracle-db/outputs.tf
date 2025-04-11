output "db_system_id" {
  description = "The OCID of the DB system"
  value       = oci_database_db_system.oracle_db.id
}

output "db_system_name" {
  description = "The display name of the DB system"
  value       = oci_database_db_system.oracle_db.display_name
}

output "db_admin_username" {
  description = "The admin username for the database"
  value       = "sys"
}

output "oracle_domain" {
  description = "The domain name for the database system"
  value       = data.oci_core_subnet.db_subnet.subnet_domain_name
}
