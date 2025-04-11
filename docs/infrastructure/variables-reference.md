# Variables Reference Guide

This document provides a comprehensive reference for all variables used in the AFID infrastructure setup.

## Table of Contents

- [Identity and Access Variables](#identity-and-access-variables)
- [Network Variables](#network-variables)
- [Cluster Variables](#cluster-variables)
- [Worker Node Variables](#worker-node-variables)
- [Monitoring Variables](#monitoring-variables)
- [Load Balancer Variables](#load-balancer-variables)
- [DNS and TLS Variables](#dns-and-tls-variables)
- [Application Variables](#application-variables)
- [Storage Variables](#storage-variables)
- [Secret Variables](#secret-variables)

## Identity and Access Variables

These variables control access to OCI and other services.

| Variable | Type | Description | Default | Required |
|----------|------|-------------|---------|----------|
| `api_fingerprint` | string | Fingerprint of the API key | - | Yes |
| `api_private_key_path` | string | Path to the API private key | - | Yes |
| `tenancy_id` | string | OCID of your tenancy | - | Yes |
| `user_id` | string | OCID of your user | - | Yes |
| `compartment_id` | string | OCID of the compartment | - | Yes |
| `region` | string | OCI region | - | Yes |
| `home_region` | string | Home region for identity resources | - | Yes |
| `ssh_public_key_path` | string | Path to your SSH public key | - | Yes |
| `ssh_private_key_path` | string | Path to your SSH private key | - | Yes |
| `github_token` | string | GitHub token for accessing repositories | - | Yes |

## Network Variables

These variables control the network configuration.

| Variable | Type | Description | Default | Required |
|----------|------|-------------|---------|----------|
| `create_vcn` | bool | Whether to create a new VCN | `true` | No |
| `vcn_id` | string | Existing VCN OCID (if not creating a new one) | `null` | No |
| `vcn_cidrs` | list(string) | CIDR blocks for the VCN | `["10.0.0.0/16"]` | No |
| `vcn_dns_label` | string | DNS label for the VCN | `"oke"` | No |
| `vcn_name` | string | Name for the VCN | `"afid_oke"` | No |
| `assign_dns` | bool | Whether to assign DNS in the VCN | `true` | No |
| `lockdown_default_seclist` | bool | Whether to remove all default security rules | `true` | No |
| `allow_worker_internet_access` | bool | Allow worker nodes to access internet | `true` | No |
| `allow_worker_ssh_access` | bool | Allow SSH access to worker nodes | `true` | No |
| `control_plane_allowed_cidrs` | list(string) | CIDRs allowed to access the control plane | `["0.0.0.0/0"]` | No |

## Cluster Variables

These variables control the Kubernetes cluster configuration.

| Variable | Type | Description | Default | Required |
|----------|------|-------------|---------|----------|
| `create_cluster` | bool | Whether to create a new cluster | `true` | No |
| `cluster_id` | string | Existing cluster OCID (if not creating a new one) | `null` | No |
| `cluster_name` | string | Name for the cluster | `"afid_oke"` | No |
| `kubernetes_version` | string | Kubernetes version | `"v1.32.1"` | No |
| `cni_type` | string | CNI type (flannel or npn) | `"flannel"` | No |
| `pods_cidr` | string | CIDR block for pods | `"10.244.0.0/16"` | No |
| `services_cidr` | string | CIDR block for services | `"10.96.0.0/16"` | No |
| `control_plane_is_public` | bool | Whether the control plane is public | `true` | No |
| `kubeconfig_filename` | string | Path to save the kubeconfig file | `"./oke-config"` | No |

## Worker Node Variables

These variables control the worker node configuration.

| Variable | Type | Description | Default | Required |
|----------|------|-------------|---------|----------|
| `worker_pool_size` | number | Default size for worker pools | `0` | No |
| `worker_pool_mode` | string | Mode for worker pools (node-pool, instance, etc.) | `"node-pool"` | No |
| `worker_pools` | map(object) | Configuration for worker pools | See example | No |
| `worker_is_public` | bool | Whether workers have public IPs | `false` | No |
| `worker_nsg_ids` | list(string) | NSG IDs for workers | `[]` | No |
| `await_node_readiness` | string | How to wait for node readiness | `"none"` | No |

**Example worker_pools configuration:**
```hcl
worker_pools = {
  static = {
    shape              = "VM.Standard.E4.Flex",
    ocpus              = 2,
    memory             = 16,
    size               = 2,
    boot_volume_size   = 200,
    kubernetes_version = "v1.32.1"
  }
  dynamic = {
    shape              = "VM.Standard.E4.Flex",
    ocpus              = 2,
    memory             = 16,
    size               = 1,
    boot_volume_size   = 200,
    kubernetes_version = "v1.32.1",
    autoscaling = {
      enabled  = true
      min_size = 1
      max_size = 4
    }
  }
}
```

## Monitoring Variables

These variables control the monitoring stack configuration.

| Variable | Type | Description | Default | Required |
|----------|------|-------------|---------|----------|
| `enable_monitoring` | bool | Whether to enable monitoring stack | `false` | No |
| `enable_otel` | bool | Whether to enable OpenTelemetry | `false` | No |
| `monitoring_namespace` | string | Namespace for monitoring components | `"monitoring"` | No |
| `otel_namespace` | string | Namespace for OpenTelemetry components | `"opentelemetry"` | No |
| `rabbitmq_namespace` | string | Namespace for RabbitMQ | `"rabbitmq"` | No |
| `loki_helm_version` | string | Helm chart version for Loki | `"5.41.6"` | No |
| `grafana_helm_version` | string | Helm chart version for Grafana | `"7.0.21"` | No |
| `vector_helm_version` | string | Helm chart version for Vector | `"0.28.0"` | No |
| `otel_collector_helm_version` | string | Helm chart version for OpenTelemetry Collector | `"0.70.0"` | No |
| `tempo_helm_version` | string | Helm chart version for Tempo | `"1.7.1"` | No |
| `rabbitmq_helm_version` | string | Helm chart version for RabbitMQ | `"12.0.3"` | No |

## Load Balancer Variables

These variables control the load balancer configuration.

| Variable | Type | Description | Default | Required |
|----------|------|-------------|---------|----------|
| `create_load_balancer` | bool | Whether to create a dedicated load balancer | `true` | No |
| `lb_subnet_ids` | list(string) | Subnet OCIDs for the load balancer | `[]` | No |
| `lb_name_prefix` | string | Prefix for the load balancer name | `"afid"` | No |
| `lb_min_bandwidth` | number | Minimum bandwidth (Mbps) | `10` | No |
| `lb_max_bandwidth` | number | Maximum bandwidth (Mbps) | `100` | No |
| `lb_is_private` | bool | Whether the load balancer is private | `false` | No |
| `lb_nsg_ids` | list(string) | NSG IDs for the load balancer | `[]` | No |
| `lb_reserved_ip_id` | string | Reserved IP OCID for the load balancer | `""` | No |
| `ingress_namespace` | string | Namespace for Nginx Ingress | `"ingress-nginx"` | No |
| `nginx_ingress_helm_version` | string | Helm chart version for Nginx Ingress | `"4.8.3"` | No |

## DNS and TLS Variables

These variables control DNS and TLS certificate configuration.

| Variable | Type | Description | Default | Required |
|----------|------|-------------|---------|----------|
| `cloudflare_api_token` | string | Cloudflare API token | - | Yes |
| `cloudflare_zone_id` | string | Cloudflare zone ID | - | Yes |
| `app_subdomain` | string | Subdomain for the application | - | Yes |
| `subdomain` | string | Subdomain for application services | `""` | No |
| `cert_manager_namespace` | string | Namespace for cert-manager | `"cert-manager"` | No |
| `cert_manager_helm_version` | string | Helm chart version for cert-manager | `"v1.13.3"` | No |
| `letsencrypt_email` | string | Email for Let's Encrypt | `""` | No |
| `letsencrypt_server` | string | Let's Encrypt server URL | `"https://acme-v02.api.letsencrypt.org/directory"` | No |

## Application Variables

These variables control the application configuration.

| Variable | Type | Description | Default | Required |
|----------|------|-------------|---------|----------|
| `environment` | string | Environment (dev, test, prod) | `"dev"` | No |
| `core_tag` | string | Tag for AFID Core images | `"latest"` | No |
| `nextjs_tag` | string | Tag for NextJS images | `"latest"` | No |
| `registry_org` | string | GitHub organization for container registry | - | Yes |

## Storage Variables

These variables control the storage configuration.

| Variable | Type | Description | Default | Required |
|----------|------|-------------|---------|----------|
| `django_s3_access_key` | string | Access key for Django S3 | `""` | No |
| `django_s3_secret_key` | string | Secret key for Django S3 | `""` | No |
| `loki_s3_access_key` | string | Access key for Loki S3 | `""` | No |
| `loki_s3_secret_key` | string | Secret key for Loki S3 | `""` | No |
| `tempo_s3_access_key` | string | Access key for Tempo S3 | `""` | No |
| `tempo_s3_secret_key` | string | Secret key for Tempo S3 | `""` | No |

## Secret Variables

These variables control various secrets used in the infrastructure.

| Variable | Type | Description | Default | Required |
|----------|------|-------------|---------|----------|
| `rabbitmq_auth_password` | string | Password for RabbitMQ | - | Yes |
| `rabbitmq_auth_erlang_cookie` | string | Erlang cookie for RabbitMQ | - | Yes |
| `oracle_db_pass` | string | Password for Oracle DB | - | Yes |
| `postgres_auth_password` | string | Password for PostgreSQL | - | Yes |
| `s3_creds_access_key` | string | General S3 access key | - | Yes |
| `s3_creds_secret_key` | string | General S3 secret key | - | Yes |
| `grafana_github_oauth_client_id` | string | GitHub OAuth client ID for Grafana | `""` | No |
| `grafana_github_oauth_client_secret` | string | GitHub OAuth client secret for Grafana | `""` | No |

## Variable Precedence

When multiple variables can provide the same information, the precedence is as follows:

1. Explicitly set variables in `terraform.tfvars`
2. Environment variables (TF_VAR_*)
3. Default values in variable declarations

For example, with S3 credentials:
- If `django_s3_access_key` is set, it will be used for Django
- Otherwise, `s3_creds_access_key` will be used
- If neither is set, the generated key from the object storage module will be used

## Sensitive Variables

The following variables contain sensitive information and should be handled securely:

- All password variables
- All secret key variables
- API tokens
- Private key paths

Consider using a secure method to manage these variables, such as:
- HashiCorp Vault
- OCI Vault
- Environment variables
- Encrypted files

## Variable Files

For different environments, consider maintaining separate variable files:

- `terraform.tfvars.dev` - Development environment
- `terraform.tfvars.test` - Testing environment
- `terraform.tfvars.prod` - Production environment

You can apply a specific variable file using:

```bash
terraform apply -var-file=terraform.tfvars.prod
```
