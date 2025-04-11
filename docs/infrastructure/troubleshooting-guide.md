# Troubleshooting Guide

This guide provides solutions for common issues that may arise during the deployment and operation of the AFID infrastructure.

## Table of Contents

- [Terraform Issues](#terraform-issues)
- [OCI Infrastructure Issues](#oci-infrastructure-issues)
- [Kubernetes Cluster Issues](#kubernetes-cluster-issues)
- [Load Balancer Issues](#load-balancer-issues)
- [Ingress Controller Issues](#ingress-controller-issues)
- [Certificate Issues](#certificate-issues)
- [DNS Issues](#dns-issues)
- [Monitoring Issues](#monitoring-issues)
- [Application Deployment Issues](#application-deployment-issues)
- [Performance Issues](#performance-issues)
- [Diagnostic Commands](#diagnostic-commands)
- [Common Error Messages](#common-error-messages)

## Terraform Issues

### Terraform Init Fails

**Symptoms:**
- Error during `terraform init`
- Provider download failures
- Authentication errors

**Solutions:**

1. **Provider Download Issues:**
   ```bash
   # Clear Terraform cache
   rm -rf .terraform
   
   # Reinitialize with debug output
   TF_LOG=DEBUG terraform init
   ```

2. **Authentication Issues:**
   - Verify API key permissions
   - Check that private key path is correct
   - Ensure fingerprint is correct

   ```bash
   # Verify OCI CLI configuration
   oci setup repair-file-permissions --file ~/.oci/config
   oci iam region list  # Test authentication
   ```

### Terraform Plan/Apply Fails

**Symptoms:**
- Error during `terraform plan` or `terraform apply`
- Resource creation failures
- State lock issues

**Solutions:**

1. **Resource Creation Failures:**
   - Check OCI service limits
   - Verify compartment permissions
   - Check for conflicting resource names

   ```bash
   # Check service limits
   oci limits resource-availability get --compartment-id <compartment_id> --service-name <service_name> --limit-name <limit_name>
   ```

2. **State Lock Issues:**
   ```bash
   # Force unlock state (use with caution)
   terraform force-unlock <lock_id>
   ```

3. **Dependency Issues:**
   - Check for circular dependencies
   - Verify that all required variables are set

   ```bash
   # Show dependencies
   terraform graph | dot -Tsvg > graph.svg
   ```

## OCI Infrastructure Issues

### VCN Creation Fails

**Symptoms:**
- Error creating VCN
- CIDR block conflicts
- DNS label issues

**Solutions:**

1. **CIDR Block Conflicts:**
   - Check for overlapping CIDR blocks
   - Verify that CIDR block is valid

   ```bash
   # List existing VCNs
   oci network vcn list --compartment-id <compartment_id>
   ```

2. **DNS Label Issues:**
   - Ensure DNS label follows naming rules
   - Check for duplicate DNS labels

### Subnet Creation Fails

**Symptoms:**
- Error creating subnets
- CIDR block conflicts
- Route table issues

**Solutions:**

1. **CIDR Block Conflicts:**
   - Check for overlapping subnet CIDR blocks
   - Verify that subnet CIDR is within VCN CIDR

   ```bash
   # List existing subnets
   oci network subnet list --compartment-id <compartment_id> --vcn-id <vcn_id>
   ```

2. **Route Table Issues:**
   - Verify route table exists
   - Check route table rules

   ```bash
   # List route tables
   oci network route-table list --compartment-id <compartment_id> --vcn-id <vcn_id>
   ```

### Load Balancer Creation Fails

**Symptoms:**
- Error creating load balancer
- Subnet issues
- Shape or bandwidth issues

**Solutions:**

1. **Subnet Issues:**
   - Verify subnets exist
   - Check that subnets are in different availability domains for HA

   ```bash
   # Verify subnet details
   oci network subnet get --subnet-id <subnet_id>
   ```

2. **Shape or Bandwidth Issues:**
   - Check service limits for load balancer shapes
   - Verify bandwidth values are within allowed range

   ```bash
   # Check load balancer shapes
   oci lb shape list --compartment-id <compartment_id>
   ```

## Kubernetes Cluster Issues

### Cluster Creation Fails

**Symptoms:**
- Error creating OKE cluster
- Control plane issues
- Network configuration issues

**Solutions:**

1. **Control Plane Issues:**
   - Check Kubernetes version availability
   - Verify control plane subnet configuration

   ```bash
   # List available Kubernetes versions
   oci ce cluster-options get --cluster-option-id all
   ```

2. **Network Configuration Issues:**
   - Verify VCN and subnet configurations
   - Check security list rules

   ```bash
   # Verify security list rules
   oci network security-list list --compartment-id <compartment_id> --vcn-id <vcn_id>
   ```

### Worker Node Issues

**Symptoms:**
- Worker nodes not joining cluster
- Node status shows NotReady
- Pod scheduling issues

**Solutions:**

1. **Nodes Not Joining:**
   - Check node pool configuration
   - Verify worker subnet configuration
   - Check security list rules

   ```bash
   # List node pools
   oci ce node-pool list --compartment-id <compartment_id> --cluster-id <cluster_id>
   
   # Get node pool details
   oci ce node-pool get --node-pool-id <node_pool_id>
   ```

2. **Node Status Issues:**
   ```bash
   # Check node status
   kubectl get nodes
   kubectl describe node <node_name>
   
   # Check kubelet logs
   kubectl get pods -n kube-system | grep kubelet
   kubectl logs -n kube-system <kubelet_pod>
   ```

### Kubeconfig Issues

**Symptoms:**
- Error generating kubeconfig
- Authentication failures
- Connection refused errors

**Solutions:**

1. **Generation Issues:**
   - Verify cluster exists and is active
   - Check permissions to access cluster

   ```bash
   # Check cluster status
   oci ce cluster get --cluster-id <cluster_id>
   ```

2. **Authentication Issues:**
   ```bash
   # Regenerate kubeconfig
   oci ce cluster create-kubeconfig --cluster-id <cluster_id> --file <kubeconfig_path> --region <region>
   
   # Test connection
   KUBECONFIG=<kubeconfig_path> kubectl get nodes
   ```

## Load Balancer Issues

### Load Balancer Not Created

**Symptoms:**
- Load balancer not appearing in OCI console
- Terraform shows creation failure
- Backend set issues

**Solutions:**

1. **Creation Issues:**
   - Check subnet configuration
   - Verify NSG rules
   - Check service limits

   ```bash
   # List load balancers
   oci lb load-balancer list --compartment-id <compartment_id>
   ```

2. **Backend Set Issues:**
   - Verify backend set configuration
   - Check health checker settings

   ```bash
   # List backend sets
   oci lb backend-set list --load-balancer-id <load_balancer_id>
   ```

### Load Balancer Not Routing Traffic

**Symptoms:**
- Services not accessible
- Health check failures
- Listener issues

**Solutions:**

1. **Health Check Issues:**
   - Verify backend health
   - Check health check configuration

   ```bash
   # Check backend health
   oci lb backend-set get-health --load-balancer-id <load_balancer_id> --backend-set-name <backend_set_name>
   ```

2. **Listener Issues:**
   - Verify listener configuration
   - Check port and protocol settings

   ```bash
   # List listeners
   oci lb listener list --load-balancer-id <load_balancer_id>
   ```

## Ingress Controller Issues

### Ingress Controller Not Starting

**Symptoms:**
- Ingress controller pods not running
- Error in pod logs
- Service account issues

**Solutions:**

1. **Pod Issues:**
   ```bash
   # Check pod status
   kubectl get pods -n ingress-nginx
   kubectl describe pod -n ingress-nginx <ingress_controller_pod>
   kubectl logs -n ingress-nginx <ingress_controller_pod>
   ```

2. **Service Account Issues:**
   ```bash
   # Check service account
   kubectl get serviceaccount -n ingress-nginx
   kubectl describe serviceaccount -n ingress-nginx <service_account_name>
   ```

### Ingress Not Routing Traffic

**Symptoms:**
- Services not accessible via ingress
- 404 or 503 errors
- Ingress resource issues

**Solutions:**

1. **Ingress Resource Issues:**
   ```bash
   # Check ingress resources
   kubectl get ingress --all-namespaces
   kubectl describe ingress -n <namespace> <ingress_name>
   ```

2. **Backend Service Issues:**
   ```bash
   # Check backend services
   kubectl get svc -n <namespace>
   kubectl describe svc -n <namespace> <service_name>
   ```

3. **Ingress Controller Configuration:**
   ```bash
   # Check ingress controller configuration
   kubectl get configmap -n ingress-nginx
   kubectl describe configmap -n ingress-nginx nginx-configuration
   ```

### Load Balancer Integration Issues

**Symptoms:**
- Ingress controller not using pre-created load balancer
- Annotations not applied
- Service type issues

**Solutions:**

1. **Annotation Issues:**
   ```bash
   # Check service annotations
   kubectl get svc -n ingress-nginx nginx-ingress-ingress-nginx-controller -o yaml
   ```

2. **Service Type Issues:**
   ```bash
   # Verify service type
   kubectl get svc -n ingress-nginx nginx-ingress-ingress-nginx-controller
   ```

3. **Load Balancer ID Issues:**
   - Verify load balancer ID is correct
   - Check that load balancer exists

   ```bash
   # Get load balancer details
   oci lb load-balancer get --load-balancer-id <load_balancer_id>
   ```

## Certificate Issues

### Cert Manager Installation Fails

**Symptoms:**
- Cert manager pods not running
- CRD installation issues
- Namespace issues

**Solutions:**

1. **Pod Issues:**
   ```bash
   # Check pod status
   kubectl get pods -n cert-manager
   kubectl describe pod -n cert-manager <cert_manager_pod>
   kubectl logs -n cert-manager <cert_manager_pod>
   ```

2. **CRD Issues:**
   ```bash
   # Check CRDs
   kubectl get crds | grep cert-manager
   ```

### Certificate Issuance Fails

**Symptoms:**
- Certificates stuck in pending state
- Challenge failures
- Let's Encrypt rate limit issues

**Solutions:**

1. **Certificate Status:**
   ```bash
   # Check certificate status
   kubectl get certificates --all-namespaces
   kubectl describe certificate -n <namespace> <certificate_name>
   ```

2. **Challenge Issues:**
   ```bash
   # Check challenges
   kubectl get challenges --all-namespaces
   kubectl describe challenge -n <namespace> <challenge_name>
   ```

3. **ClusterIssuer Issues:**
   ```bash
   # Check cluster issuer
   kubectl get clusterissuers
   kubectl describe clusterissuer <issuer_name>
   ```

4. **Let's Encrypt Rate Limits:**
   - Use staging server for testing
   - Check rate limit status

   ```bash
   # Switch to staging server
   kubectl edit clusterissuer <issuer_name>
   # Change server to https://acme-staging-v02.api.letsencrypt.org/directory
   ```

## DNS Issues

### DNS Record Creation Fails

**Symptoms:**
- Error creating DNS records
- Cloudflare API errors
- Zone ID issues

**Solutions:**

1. **API Token Issues:**
   - Verify Cloudflare API token has correct permissions
   - Check that token is valid

2. **Zone ID Issues:**
   - Verify zone ID is correct
   - Check that domain is in the specified zone

   ```bash
   # List zones (using Cloudflare CLI if available)
   cloudflare zone list
   ```

### DNS Resolution Issues

**Symptoms:**
- Domain not resolving to correct IP
- DNS propagation delays
- Record configuration issues

**Solutions:**

1. **Record Configuration:**
   ```bash
   # Check DNS records (using Cloudflare CLI if available)
   cloudflare dns list <zone_id>
   ```

2. **DNS Propagation:**
   - Wait for DNS propagation (can take up to 24 hours)
   - Use DNS lookup tools to check propagation

   ```bash
   # Check DNS resolution
   dig <domain>
   nslookup <domain>
   ```

## Monitoring Issues

### Monitoring Stack Installation Fails

**Symptoms:**
- Loki, Grafana, or Vector pods not running
- PVC issues
- Configuration issues

**Solutions:**

1. **Pod Issues:**
   ```bash
   # Check pod status
   kubectl get pods -n monitoring
   kubectl describe pod -n monitoring <pod_name>
   kubectl logs -n monitoring <pod_name>
   ```

2. **PVC Issues:**
   ```bash
   # Check PVCs
   kubectl get pvc -n monitoring
   kubectl describe pvc -n monitoring <pvc_name>
   ```

3. **Configuration Issues:**
   ```bash
   # Check configmaps
   kubectl get configmap -n monitoring
   kubectl describe configmap -n monitoring <configmap_name>
   ```

### Grafana Access Issues

**Symptoms:**
- Cannot access Grafana dashboard
- Authentication issues
- Ingress issues

**Solutions:**

1. **Ingress Issues:**
   ```bash
   # Check ingress
   kubectl get ingress -n monitoring
   kubectl describe ingress -n monitoring <ingress_name>
   ```

2. **Service Issues:**
   ```bash
   # Check service
   kubectl get svc -n monitoring grafana
   kubectl describe svc -n monitoring grafana
   ```

3. **Authentication Issues:**
   ```bash
   # Check Grafana admin secret
   kubectl get secret -n monitoring grafana
   ```

## Application Deployment Issues

### Helm Chart Installation Fails

**Symptoms:**
- Error installing Helm charts
- Repository access issues
- Value configuration issues

**Solutions:**

1. **Repository Issues:**
   ```bash
   # Check Helm repositories
   helm repo list
   helm repo update
   ```

2. **Chart Access Issues:**
   - Verify GitHub token has correct permissions
   - Check that chart exists in repository

   ```bash
   # List available charts
   helm search repo <repository_name>
   ```

3. **Value Configuration Issues:**
   ```bash
   # Validate values
   helm lint <chart_name> -f <values_file>
   ```

### Application Pods Not Running

**Symptoms:**
- Pods stuck in pending or crashloopbackoff
- Image pull issues
- Resource constraint issues

**Solutions:**

1. **Pod Status Issues:**
   ```bash
   # Check pod status
   kubectl get pods -n <namespace>
   kubectl describe pod -n <namespace> <pod_name>
   kubectl logs -n <namespace> <pod_name>
   ```

2. **Image Pull Issues:**
   - Verify image exists
   - Check image pull secrets

   ```bash
   # Check image pull secrets
   kubectl get secrets -n <namespace> | grep docker
   ```

3. **Resource Constraint Issues:**
   - Check node resources
   - Verify pod resource requests and limits

   ```bash
   # Check node resources
   kubectl describe node <node_name>
   
   # Check pod resource requests
   kubectl get pod -n <namespace> <pod_name> -o yaml | grep resources -A 10
   ```

## Performance Issues

### Slow Application Response

**Symptoms:**
- High latency
- Slow page loads
- Resource bottlenecks

**Solutions:**

1. **Resource Utilization:**
   ```bash
   # Check node resource usage
   kubectl top nodes
   
   # Check pod resource usage
   kubectl top pods --all-namespaces
   ```

2. **Network Issues:**
   ```bash
   # Check network policies
   kubectl get networkpolicies --all-namespaces
   
   # Check service endpoints
   kubectl get endpoints -n <namespace> <service_name>
   ```

3. **Load Balancer Performance:**
   - Check load balancer metrics
   - Adjust bandwidth settings if needed

### Memory or CPU Pressure

**Symptoms:**
- OOMKilled pods
- CPU throttling
- Node pressure

**Solutions:**

1. **Pod Resource Adjustments:**
   ```bash
   # Adjust pod resources
   kubectl edit deployment -n <namespace> <deployment_name>
   # Increase resources.requests.memory and resources.limits.memory
   ```

2. **Node Scaling:**
   - Increase worker node size
   - Add more worker nodes

   ```hcl
   # Increase worker node resources
   worker_pools = {
     static = {
       ocpus              = 4,  # Increase from 2
       memory             = 32, # Increase from 16
       size               = 3,  # Increase from 2
     }
   }
   ```

## Diagnostic Commands

### Terraform Diagnostics

```bash
# Enable Terraform logging
export TF_LOG=DEBUG
export TF_LOG_PATH=./terraform.log

# Show Terraform state
terraform state list
terraform state show <resource>

# Validate Terraform configuration
terraform validate

# Show Terraform plan
terraform plan -out=plan.out
terraform show plan.out
```

### OCI Diagnostics

```bash
# List compartments
oci iam compartment list --compartment-id <tenancy_id>

# List VCNs
oci network vcn list --compartment-id <compartment_id>

# List subnets
oci network subnet list --compartment-id <compartment_id> --vcn-id <vcn_id>

# List load balancers
oci lb load-balancer list --compartment-id <compartment_id>

# List OKE clusters
oci ce cluster list --compartment-id <compartment_id>
```

### Kubernetes Diagnostics

```bash
# Set kubeconfig
export KUBECONFIG=./oke-config

# Check cluster info
kubectl cluster-info
kubectl get nodes -o wide
kubectl get namespaces

# Check all resources
kubectl get all --all-namespaces

# Check events
kubectl get events --sort-by=.metadata.creationTimestamp

# Check logs
kubectl logs -n <namespace> <pod_name>

# Check pod details
kubectl describe pod -n <namespace> <pod_name>

# Check service details
kubectl describe svc -n <namespace> <service_name>

# Check ingress details
kubectl describe ingress -n <namespace> <ingress_name>
```

### Network Diagnostics

```bash
# Test DNS resolution
dig <domain>
nslookup <domain>

# Test connectivity
curl -v https://<domain>
wget -O- https://<domain>

# Test TLS
openssl s_client -connect <domain>:443 -servername <domain>
```

## Common Error Messages

### Terraform Errors

| Error Message | Possible Cause | Solution |
|---------------|----------------|----------|
| `Error: Provider configuration not present` | Provider not initialized | Run `terraform init` |
| `Error: Invalid provider configuration` | Incorrect provider configuration | Check provider block in Terraform files |
| `Error: Error acquiring the state lock` | State lock already held | Wait or force-unlock if necessary |
| `Error: Resource not found` | Resource doesn't exist | Check resource ID or create the resource |

### OCI Errors

| Error Message | Possible Cause | Solution |
|---------------|----------------|----------|
| `ServiceError: NotAuthorizedOrNotFound` | Insufficient permissions or resource not found | Check IAM policies and resource existence |
| `LimitExceeded` | Service limit reached | Request limit increase or delete unused resources |
| `InvalidParameter` | Invalid parameter value | Check parameter values against documentation |
| `Conflict` | Resource already exists | Use existing resource or choose different name |

### Kubernetes Errors

| Error Message | Possible Cause | Solution |
|---------------|----------------|----------|
| `Error from server (NotFound)` | Resource doesn't exist | Check resource name and namespace |
| `Error from server (Forbidden)` | Insufficient permissions | Check RBAC configuration |
| `ImagePullBackOff` | Cannot pull container image | Check image name and pull secrets |
| `CrashLoopBackOff` | Container crashing | Check container logs for errors |
| `Pending` | Pod cannot be scheduled | Check node resources and pod requirements |

### Certificate Errors

| Error Message | Possible Cause | Solution |
|---------------|----------------|----------|
| `Waiting for CertificateRequest to complete` | Certificate issuance in progress | Wait for issuance to complete |
| `Failed to create Order: 429` | Let's Encrypt rate limit reached | Use staging server or wait for rate limit reset |
| `Failed to create Challenge: 404` | DNS or HTTP challenge failed | Check DNS configuration or HTTP accessibility |
| `Failed to finalize order: acme: error` | ACME protocol error | Check ACME server logs and configuration |

## Conclusion

This troubleshooting guide covers common issues that may arise during the deployment and operation of the AFID infrastructure. By following the diagnostic steps and solutions provided, you can quickly identify and resolve problems to ensure a smooth deployment and operation of your infrastructure.

If you encounter issues not covered in this guide, consider:

1. Checking the official documentation for the specific component
2. Reviewing logs and events for more detailed error information
3. Consulting the OCI and Kubernetes communities for similar issues
4. Opening a support ticket if you have Oracle support
