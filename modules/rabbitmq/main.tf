# modules/rabbitmq/main.tf

# RabbitMQ server with management dashboard
resource "helm_release" "rabbitmq" {
  name             = "rabbitmq"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "rabbitmq"
  version          = var.rabbitmq_helm_version
  namespace        = var.rabbitmq_namespace
  create_namespace = true
  timeout          = 600
  atomic           = true
  cleanup_on_fail  = true
  lint             = true

  values = [<<-EOT
    auth:
      existingPasswordSecret: rabbitmq-auth
      existingErlangSecret: rabbitmq-auth
      username: afid
    metrics:
      enabled: true
      serviceMonitor:
        enabled: true

    extraConfiguration: |
      prometheus.return_per_object_metrics = true
    
    persistence:
      enabled: true
      size: 8Gi
    
    resources:
      requests:
        memory: 256Mi
        cpu: 100m
      limits:
        memory: 512Mi
        cpu: 200m
    
    replicaCount: 1
    EOT
  ]
}
