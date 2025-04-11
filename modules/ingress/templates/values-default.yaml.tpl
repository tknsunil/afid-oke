controller:
  service:
    type: LoadBalancer
    annotations:
      service.beta.kubernetes.io/oci-load-balancer-shape: "flexible"
      service.beta.kubernetes.io/oci-load-balancer-shape-flex-min: "${lb_min_bandwidth}"
      service.beta.kubernetes.io/oci-load-balancer-shape-flex-max: "${lb_max_bandwidth}"
  config:
    use-forwarded-headers: "true"
    proxy-buffer-size: "16k"
  metrics:
    enabled: true
    serviceMonitor:
      enabled: ${enable_monitoring}
