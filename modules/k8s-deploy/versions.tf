# Copyright (c) 2017, 2023 Oracle Corporation and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

terraform {
  required_version = ">= 1.3.0"

  required_providers {

    kubernetes = { # Add kubernetes provider
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.9.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "~>3.0"
    }
  }
}

