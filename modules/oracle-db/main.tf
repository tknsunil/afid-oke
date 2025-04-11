

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

data "oci_core_subnet" "db_subnet" {
  subnet_id = var.subnet_id
}

# Create a database system
resource "oci_database_db_system" "oracle_db" {

  availability_domain     = local.availability_domain
  compartment_id          = var.compartment_id
  database_edition        = var.db_edition
  cpu_core_count          = 2
  data_storage_size_in_gb = var.db_storage_size_in_gb
  disk_redundancy         = "NORMAL"
  shape                   = local.db_shape
  subnet_id               = var.subnet_id
  ssh_public_keys         = [file(var.ssh_public_key_path)]
  display_name            = var.db_display_name
  hostname                = var.db_hostname
  node_count              = var.db_node_count
  time_zone               = var.db_time_zone
  domain                  = data.oci_core_subnet.db_subnet.subnet_domain_name

  db_home {
    database {
      admin_password = var.db_admin_password
      db_name        = var.db_name
      character_set  = var.db_character_set
      ncharacter_set = var.db_ncharacter_set
      pdb_name       = var.db_pdb_name
    }

    db_version   = var.db_version
    display_name = "${var.db_display_name}Home"
  }

  freeform_tags = local.common_tags
  defined_tags  = var.db_defined_tags

  lifecycle {
    ignore_changes = [
      ssh_public_keys,
    ]
  }
}

resource "oci_database_db_home" "oracle_db_home" {
  count = var.db_backup_enabled ? 1 : 0

  database {
    admin_password = var.db_admin_password
    db_name        = var.db_name
    db_backup_config {
      auto_backup_enabled     = true
      auto_backup_window      = var.db_auto_backup_window
      recovery_window_in_days = var.db_recovery_window_in_days
      backup_destination_details {
        id   = oci_database_db_system.oracle_db.id
        type = "DB_SYSTEM"
      }
    }
  }

  db_system_id = oci_database_db_system.oracle_db.id
  db_version   = var.db_version
  display_name = "${var.db_display_name}Home"

  freeform_tags = local.common_tags
  defined_tags  = var.db_defined_tags

  depends_on = [oci_database_db_system.oracle_db]
}
