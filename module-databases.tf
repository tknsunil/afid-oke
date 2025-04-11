# Oracle Database setup
module "oracle_db" {
  count  = 0
  source = "./modules/oracle-db"

  compartment_id = var.compartment_id
  subnet_id      = module.network.worker_subnet_id
  environment    = var.environment

  # Database configuration
  db_admin_password   = var.oracle_db_admin_password
  db_pdb_name         = var.oracle_db_pdb_name
  ssh_public_key_path = pathexpand(var.ssh_public_key_path)

}

# PostgreSQL Database setup
module "postgres_db" {
  count  = 0
  source = "./modules/postgres-db"

  namespace         = var.kubernetes_namespace
  storage_class     = var.postgres_db_storage_class
  pvc_size          = var.postgres_db_pvc_size
  postgres_password = var.postgres_db_password
  postgres_username = var.postgres_db_username
  postgres_database = var.postgres_db_database
  postgres_port     = var.postgres_db_port
  chart_version     = "12.5.7"


  depends_on = [
    time_sleep.kubeconfig_setup
  ]
}

