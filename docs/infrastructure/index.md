# AFID Infrastructure Documentation

Welcome to the AFID Infrastructure documentation. This comprehensive guide provides detailed information on setting up, configuring, and maintaining the AFID infrastructure on Oracle Cloud Infrastructure (OCI).

## Documentation Overview

This documentation is organized into several sections to help you navigate and find the information you need:

1. **[README](README.md)** - Overview, architecture, and general information
2. **[Variables Reference](variables-reference.md)** - Detailed reference for all configuration variables
3. **[Deployment Workflow](deployment-workflow.md)** - Step-by-step deployment process with flowcharts
4. **[Fine-Tuning Guide](fine-tuning-guide.md)** - Recommendations for optimizing the infrastructure
5. **[Troubleshooting Guide](troubleshooting-guide.md)** - Solutions for common issues

## Quick Start

To get started quickly, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/your-org/terraform-oci-oke.git
   cd terraform-oci-oke
   ```

2. Copy the example variables file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. Edit the variables file to match your environment:
   ```bash
   vim terraform.tfvars
   ```

4. Initialize Terraform:
   ```bash
   terraform init
   ```

5. Plan the deployment:
   ```bash
   terraform plan
   ```

6. Apply the configuration:
   ```bash
   terraform apply
   ```

## Infrastructure Components

The AFID infrastructure consists of the following main components:

- **Oracle Kubernetes Engine (OKE)** - Managed Kubernetes cluster
- **Load Balancer** - OCI Load Balancer for ingress traffic
- **Monitoring Stack** - Loki, Grafana, and Vector for monitoring
- **OpenTelemetry** - Distributed tracing with Tempo
- **RabbitMQ** - Message broker
- **Nginx Ingress** - Ingress controller
- **Cert Manager** - TLS certificate management
- **DNS** - Cloudflare DNS configuration
- **AFID Applications** - Core and Detectors applications

## Support and Feedback

If you encounter any issues or have feedback on the documentation, please contact the AFID infrastructure team or open an issue in the repository.

---

**Note:** This documentation is maintained by the AFID infrastructure team and is subject to change as the infrastructure evolves.
