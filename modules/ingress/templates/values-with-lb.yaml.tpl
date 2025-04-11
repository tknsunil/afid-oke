controller:
  service:
    type: LoadBalancer
    annotations:
      service.beta.kubernetes.io/oci-load-balancer-id: "${load_balancer_id}"
      service.beta.kubernetes.io/oci-load-balancer-backend-protocol: "HTTP"
      service.beta.kubernetes.io/oci-load-balancer-backend-set-name: "${http_backend_set}"
      service.beta.kubernetes.io/oci-load-balancer-tls-backend-set-name: "${https_backend_set}"
  config:
    use-forwarded-headers: "true"
    proxy-buffer-size: "16k"
  metrics:
    enabled: true
    serviceMonitor:
      enabled: ${enable_monitoring}
