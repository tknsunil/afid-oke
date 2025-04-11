# Fine-Tuning Guide

This guide provides detailed instructions for fine-tuning the AFID infrastructure for different environments and workloads.

## Table of Contents

- [Environment-Specific Configurations](#environment-specific-configurations)
  - [Development Environment](#development-environment)
  - [Testing Environment](#testing-environment)
  - [Production Environment](#production-environment)
- [Resource Optimization](#resource-optimization)
  - [Worker Node Sizing](#worker-node-sizing)
  - [Load Balancer Sizing](#load-balancer-sizing)
  - [Storage Configuration](#storage-configuration)
- [Performance Tuning](#performance-tuning)
  - [Kubernetes Settings](#kubernetes-settings)
  - [Nginx Ingress Tuning](#nginx-ingress-tuning)
  - [Database Tuning](#database-tuning)
  - [RabbitMQ Tuning](#rabbitmq-tuning)
- [Security Hardening](#security-hardening)
  - [Network Security](#network-security)
  - [Kubernetes Security](#kubernetes-security)
  - [Certificate Management](#certificate-management)
- [High Availability](#high-availability)
  - [Multi-AD Deployment](#multi-ad-deployment)
  - [Worker Node Distribution](#worker-node-distribution)
  - [Load Balancer Redundancy](#load-balancer-redundancy)
- [Cost Optimization](#cost-optimization)
  - [Resource Rightsizing](#resource-rightsizing)
  - [Autoscaling Configuration](#autoscaling-configuration)
  - [Storage Tiering](#storage-tiering)

## Environment-Specific Configurations

### Development Environment

Development environments prioritize flexibility and cost-efficiency over high availability and performance.

```hcl
# terraform.tfvars.dev

# Cluster configuration
kubernetes_version = "v1.32.1"

# Worker configuration
worker_pools = {
  static = {
    shape              = "VM.Standard.E4.Flex",
    ocpus              = 1,
    memory             = 8,
    size               = 1,
    boot_volume_size   = 100,
    kubernetes_version = "v1.32.1"
  }
}

# Load balancer configuration
create_load_balancer = true
lb_min_bandwidth     = 10
lb_max_bandwidth     = 50

# Monitoring configuration
enable_monitoring    = false
enable_otel          = false

# Certificate configuration
letsencrypt_server   = "https://acme-staging-v02.api.letsencrypt.org/directory"
```

**Key Considerations:**
- Use minimal worker resources (1 OCPU, 8GB memory)
- Single worker node to reduce costs
- Smaller boot volume size
- Use Let's Encrypt staging server to avoid rate limits
- Disable monitoring and OpenTelemetry to reduce resource usage
- Minimal load balancer bandwidth

### Testing Environment

Testing environments balance cost-efficiency with realistic performance characteristics.

```hcl
# terraform.tfvars.test

# Cluster configuration
kubernetes_version = "v1.32.1"

# Worker configuration
worker_pools = {
  static = {
    shape              = "VM.Standard.E4.Flex",
    ocpus              = 2,
    memory             = 16,
    size               = 2,
    boot_volume_size   = 150,
    kubernetes_version = "v1.32.1"
  }
}

# Load balancer configuration
create_load_balancer = true
lb_min_bandwidth     = 10
lb_max_bandwidth     = 100

# Monitoring configuration
enable_monitoring    = true
enable_otel          = true

# Certificate configuration
letsencrypt_server   = "https://acme-staging-v02.api.letsencrypt.org/directory"
```

**Key Considerations:**
- Moderate worker resources (2 OCPUs, 16GB memory)
- Two worker nodes for basic redundancy
- Medium boot volume size
- Enable monitoring and OpenTelemetry for testing observability
- Still use Let's Encrypt staging server
- Moderate load balancer bandwidth

### Production Environment

Production environments prioritize reliability, performance, and security.

```hcl
# terraform.tfvars.prod

# Cluster configuration
kubernetes_version = "v1.32.1"

# Worker configuration
worker_pools = {
  static = {
    shape              = "VM.Standard.E4.Flex",
    ocpus              = 4,
    memory             = 32,
    size               = 3,
    boot_volume_size   = 200,
    kubernetes_version = "v1.32.1"
  }
  dynamic = {
    shape              = "VM.Standard.E4.Flex",
    ocpus              = 4,
    memory             = 32,
    size               = 1,
    boot_volume_size   = 200,
    kubernetes_version = "v1.32.1",
    autoscaling = {
      enabled  = true
      min_size = 1
      max_size = 5
    }
  }
}

# Load balancer configuration
create_load_balancer = true
lb_min_bandwidth     = 50
lb_max_bandwidth     = 500

# Monitoring configuration
enable_monitoring    = true
enable_otel          = true

# Certificate configuration
letsencrypt_server   = "https://acme-v02.api.letsencrypt.org/directory"
```

**Key Considerations:**
- Robust worker resources (4 OCPUs, 32GB memory)
- Three static worker nodes for high availability
- Additional dynamic worker pool with autoscaling
- Larger boot volume size
- Enable monitoring and OpenTelemetry for production observability
- Use Let's Encrypt production server
- Higher load balancer bandwidth for production traffic

## Resource Optimization

### Worker Node Sizing

Worker node sizing depends on your workload characteristics:

| Workload Type | Recommended Configuration |
|---------------|---------------------------|
| CPU-intensive | Higher OCPUs, moderate memory |
| Memory-intensive | Moderate OCPUs, higher memory |
| Balanced | Equal ratio of OCPUs to memory (1:8 GB) |

**CPU-intensive workload example:**
```hcl
worker_pools = {
  static = {
    shape              = "VM.Standard.E4.Flex",
    ocpus              = 8,
    memory             = 32,
    size               = 3,
    boot_volume_size   = 200,
    kubernetes_version = "v1.32.1"
  }
}
```

**Memory-intensive workload example:**
```hcl
worker_pools = {
  static = {
    shape              = "VM.Standard.E4.Flex",
    ocpus              = 4,
    memory             = 64,
    size               = 3,
    boot_volume_size   = 200,
    kubernetes_version = "v1.32.1"
  }
}
```

**Balanced workload example:**
```hcl
worker_pools = {
  static = {
    shape              = "VM.Standard.E4.Flex",
    ocpus              = 4,
    memory             = 32,
    size               = 3,
    boot_volume_size   = 200,
    kubernetes_version = "v1.32.1"
  }
}
```

### Load Balancer Sizing

Load balancer sizing depends on your traffic patterns:

| Traffic Level | Recommended Configuration |
|---------------|---------------------------|
| Low | 10 Mbps min, 50 Mbps max |
| Medium | 50 Mbps min, 100 Mbps max |
| High | 100 Mbps min, 500 Mbps max |
| Very High | 500 Mbps min, 1000 Mbps max |

**Low traffic example:**
```hcl
lb_min_bandwidth     = 10
lb_max_bandwidth     = 50
```

**Medium traffic example:**
```hcl
lb_min_bandwidth     = 50
lb_max_bandwidth     = 100
```

**High traffic example:**
```hcl
lb_min_bandwidth     = 100
lb_max_bandwidth     = 500
```

**Very high traffic example:**
```hcl
lb_min_bandwidth     = 500
lb_max_bandwidth     = 1000
```

### Storage Configuration

Storage configuration depends on your data retention needs:

| Component | Low Retention | Medium Retention | High Retention |
|-----------|---------------|------------------|----------------|
| Loki | 7 days | 30 days | 90+ days |
| Tempo | 3 days | 14 days | 30+ days |
| Application | 50 GB | 100 GB | 200+ GB |

**Low retention example:**
```hcl
loki_retention_time_amount  = 7
tempo_retention_time_amount = 3
```

**Medium retention example:**
```hcl
loki_retention_time_amount  = 30
tempo_retention_time_amount = 14
```

**High retention example:**
```hcl
loki_retention_time_amount  = 90
tempo_retention_time_amount = 30
```

## Performance Tuning

### Kubernetes Settings

Optimize Kubernetes settings for better performance:

```hcl
# Optimize etcd
etcd_cluster_size = 3

# Optimize API server
api_server_max_requests_inflight = 800
api_server_max_mutating_requests_inflight = 400

# Optimize kubelet
kubelet_max_pods = 110
```

### Nginx Ingress Tuning

Tune Nginx Ingress for better performance:

```hcl
# Create a values file for Nginx Ingress
# values-nginx-ingress.yaml
controller:
  config:
    use-forwarded-headers: "true"
    proxy-buffer-size: "16k"
    proxy-body-size: "50m"
    keep-alive: "75"
    keep-alive-requests: "100"
    upstream-keepalive-connections: "200"
    worker-processes: "auto"
  resources:
    requests:
      cpu: 100m
      memory: 256Mi
    limits:
      cpu: 500m
      memory: 512Mi
```

Apply these settings when installing Nginx Ingress:

```bash
helm upgrade --install nginx-ingress ingress-nginx/ingress-nginx \
  -f values-nginx-ingress.yaml \
  --namespace ingress-nginx
```

### Database Tuning

If using a database, tune it for better performance:

```hcl
# PostgreSQL example
postgresql:
  resources:
    requests:
      cpu: 1000m
      memory: 2Gi
    limits:
      cpu: 2000m
      memory: 4Gi
  postgresql:
    max_connections: 200
    shared_buffers: 1GB
    effective_cache_size: 3GB
    work_mem: 16MB
    maintenance_work_mem: 256MB
```

### RabbitMQ Tuning

Tune RabbitMQ for better performance:

```hcl
# RabbitMQ example
rabbitmq:
  resources:
    requests:
      cpu: 500m
      memory: 1Gi
    limits:
      cpu: 1000m
      memory: 2Gi
  rabbitmq:
    additionalConfig: |
      vm_memory_high_watermark.relative = 0.8
      disk_free_limit.absolute = 2GB
      tcp_listen_options.backlog = 4096
      tcp_listen_options.sndbuf = 32768
      tcp_listen_options.recbuf = 32768
```

## Security Hardening

### Network Security

Enhance network security with these configurations:

```hcl
# Restrict control plane access
control_plane_allowed_cidrs = ["10.0.0.0/16", "192.168.1.0/24"]

# Disable public worker nodes
worker_is_public = false

# Enable network policies
enable_network_policy = true

# Restrict node port access
allow_node_port_access = false
```

### Kubernetes Security

Enhance Kubernetes security with these configurations:

```hcl
# Enable pod security policies
enable_pod_security_policy = true

# Use signed images
use_signed_images = true
image_signing_keys = ["ocid1.key.oc1..."]

# Enable OPA Gatekeeper
gatekeeper_install = true
```

### Certificate Management

Enhance certificate security with these configurations:

```hcl
# Use production Let's Encrypt server
letsencrypt_server = "https://acme-v02.api.letsencrypt.org/directory"

# Configure DNS01 challenge for wildcard certificates
cert_manager_dns01_config = {
  provider = "cloudflare"
  email    = "admin@example.com"
}
```

## High Availability

### Multi-AD Deployment

Deploy across multiple availability domains for high availability:

```hcl
# Specify availability domains
availability_domains = ["AD-1", "AD-2", "AD-3"]

# Distribute worker nodes
worker_pools = {
  ad1 = {
    availability_domain = "AD-1"
    shape               = "VM.Standard.E4.Flex",
    ocpus               = 4,
    memory              = 32,
    size                = 1,
    boot_volume_size    = 200,
    kubernetes_version  = "v1.32.1"
  },
  ad2 = {
    availability_domain = "AD-2"
    shape               = "VM.Standard.E4.Flex",
    ocpus               = 4,
    memory              = 32,
    size                = 1,
    boot_volume_size    = 200,
    kubernetes_version  = "v1.32.1"
  },
  ad3 = {
    availability_domain = "AD-3"
    shape               = "VM.Standard.E4.Flex",
    ocpus               = 4,
    memory              = 32,
    size                = 1,
    boot_volume_size    = 200,
    kubernetes_version  = "v1.32.1"
  }
}
```

### Worker Node Distribution

Distribute worker nodes for better availability:

```hcl
# Use fault domains
worker_pools = {
  static = {
    shape              = "VM.Standard.E4.Flex",
    ocpus              = 4,
    memory             = 32,
    size               = 3,
    boot_volume_size   = 200,
    kubernetes_version = "v1.32.1",
    fault_domains      = ["FAULT-DOMAIN-1", "FAULT-DOMAIN-2", "FAULT-DOMAIN-3"]
  }
}
```

### Load Balancer Redundancy

Configure load balancer for high availability:

```hcl
# Use regional subnets
lb_subnet_ids = ["ocid1.subnet.oc1.phx.aaaa...", "ocid1.subnet.oc1.phx.bbbb..."]

# Configure backup policy
lb_backup_policy = {
  policy_name = "daily-backup"
  schedule    = "0 0 * * *"
  retention   = 7
}
```

## Cost Optimization

### Resource Rightsizing

Rightsize resources to optimize costs:

```hcl
# Use smaller shapes for non-production
worker_pools = {
  static = {
    shape              = "VM.Standard.E3.Flex",  # Cheaper than E4
    ocpus              = 2,
    memory             = 16,
    size               = 2,
    boot_volume_size   = 100,
    kubernetes_version = "v1.32.1"
  }
}

# Use smaller load balancer
lb_min_bandwidth     = 10
lb_max_bandwidth     = 50
```

### Autoscaling Configuration

Configure autoscaling to optimize costs:

```hcl
# Use autoscaling for dynamic workloads
worker_pools = {
  static = {
    shape              = "VM.Standard.E4.Flex",
    ocpus              = 2,
    memory             = 16,
    size               = 1,  # Minimum base capacity
    boot_volume_size   = 200,
    kubernetes_version = "v1.32.1"
  },
  dynamic = {
    shape              = "VM.Standard.E4.Flex",
    ocpus              = 2,
    memory             = 16,
    size               = 0,  # Start with zero
    boot_volume_size   = 200,
    kubernetes_version = "v1.32.1",
    autoscaling = {
      enabled  = true
      min_size = 0
      max_size = 5
    }
  }
}
```

### Storage Tiering

Use storage tiering to optimize costs:

```hcl
# Use standard storage for non-critical data
storage_tier = "standard"

# Use performance storage for critical data
critical_storage_tier = "performance"

# Configure lifecycle policies
storage_lifecycle_policy = {
  enabled = true
  rules = [
    {
      name = "archive-old-logs"
      target = "archive"
      days_since_creation = 30
    }
  ]
}
```

## Conclusion

This fine-tuning guide provides detailed recommendations for optimizing the AFID infrastructure for different environments and workloads. By carefully configuring resources, performance settings, security measures, high availability features, and cost optimization strategies, you can create an infrastructure that meets your specific requirements while maintaining efficiency and reliability.
