# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/


locals {
  icmp_protocol = 1
  tcp_protocol  = 6
  all_protocols = "all"

  anywhere = "0.0.0.0/0"

  db_port = 1521

  ssh_port = 22

  db_shape = var.db_shape != "" ? var.db_shape : (
    var.db_is_free_tier ? "VM.Standard.E2.1.Micro" : (
      var.environment == "dev" ? "VM.Standard2.1" : (
        var.environment == "test" ? "VM.Standard2.2" : "VM.Standard2.4"
      )
    )
  )

  # Set availability domain if not provided
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name

  # Set backup subnet ID if not provided
  backup_subnet_id = var.subnet_id

  # Common tags for all resources
  common_tags = merge(
    var.db_freeform_tags,
    {
      "Environment" = var.environment
      "Terraform"   = "true"
      "Service"     = "OracleDB"
    }
  )
}
