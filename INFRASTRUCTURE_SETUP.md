# Infrastructure Setup Guide

This guide explains how to set up the complete infrastructure for the AFID application on Oracle Cloud Infrastructure (OCI) using Terraform.

## Prerequisites

1. Oracle Cloud Infrastructure (OCI) account
2. Terraform installed (version >= 1.3.0)
3. OCI CLI configured with API keys
4. Cloudflare account with API token (for DNS management)
5. GitHub token with access to the AFID repositories

## Configuration

1. Copy the `terraform.tfvars.example` file to `terraform.tfvars`:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit the `terraform.tfvars` file to set your specific values:
   - OCI credentials and region
   - SSH keys
   - Networking configuration
   - Cluster configuration
   - Monitoring and OpenTelemetry flags
   - Cloudflare DNS configuration
   - Application subdomain
   - Load balancer configuration

3. Important variables to configure:
   ```
   # Enable monitoring and OpenTelemetry
   enable_monitoring = true
   enable_otel = true

   # Subdomain for application services
   subdomain = "your-subdomain.example.com"

   # Cloudflare configuration
   cloudflare_zone_id = "your-cloudflare-zone-id"
   letsencrypt_email = "your-email@example.com"

   # Load balancer configuration
   create_load_balancer = true
   lb_subnet_ids = ["ocid1.subnet.oc1..."] # Subnet OCIDs where the load balancer will be placed
   lb_min_bandwidth = 10
   lb_max_bandwidth = 100
   lb_is_private = false
   ```

## Deployment

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Plan the deployment:
   ```bash
   terraform plan
   ```

3. Apply the configuration:
   ```bash
   terraform apply
   ```

## Deployment Process

The deployment follows this sequence:

1. Set up OCI infrastructure (VCN, subnets, security lists)
2. Create OKE cluster and worker nodes
3. Generate kubeconfig file for cluster access
4. Install Kubernetes secrets from the k8s-secrets module
5. Install monitoring stack (Loki, Grafana, Vector) if enabled
6. Install OpenTelemetry with Tempo if enabled
7. Install RabbitMQ server with management dashboard
8. Create a dedicated load balancer for the Nginx Ingress controller (if enabled)
9. Install Nginx Ingress controller and configure it to use the pre-created load balancer
10. Update Cloudflare DNS with the load balancer IP
11. Install cert-manager and configure Let's Encrypt
12. Deploy AFID Detectors
13. Deploy AFID Core

### Load Balancer Configuration

You have two options for the load balancer:

1. **Pre-created Load Balancer (Recommended)**: Set `create_load_balancer = true` to have Terraform create a dedicated OCI Load Balancer before installing the Nginx Ingress controller. The Ingress controller will be configured to use this load balancer.

2. **Automatic Load Balancer**: Set `create_load_balancer = false` to let the Nginx Ingress controller create its own load balancer automatically.

Using a pre-created load balancer gives you more control over the load balancer configuration and allows you to specify settings like bandwidth, network security groups, and reserved IPs.

## Accessing Services

After deployment, you can access the following services:

- Main application: `https://<subdomain>`
- Grafana dashboard: `https://monitoring.<subdomain>`
- RabbitMQ management: `https://rabbitmq.<subdomain>`

## Troubleshooting

If you encounter issues:

1. Check the Terraform output for errors
2. Verify the kubeconfig file was generated correctly
3. Check the status of Kubernetes resources:
   ```bash
   export KUBECONFIG=./oke-config
   kubectl get pods --all-namespaces
   ```
4. Check Helm releases:
   ```bash
   kubectl get helmreleases --all-namespaces
   ```
5. Check ingress resources:
   ```bash
   kubectl get ingress --all-namespaces
   ```

## Cleanup

To destroy the infrastructure:
```bash
terraform destroy
```

**Note:** This will delete all resources including the Kubernetes cluster and any data stored in it.
