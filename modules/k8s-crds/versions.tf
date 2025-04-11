# Copyright (c) 2017, 2023 Oracle Corporation and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.9.0"
    }

    oci = {
      source  = "oracle/oci"
      version = ">= 4.119.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.1"
    }
  }
}
