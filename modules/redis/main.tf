
# Deploy Redis using Helm chart
resource "helm_release" "redis" {
  #   count = 0
  name            = var.release_name
  repository      = var.chart_repository
  chart           = "redis"
  version         = var.chart_version
  namespace       = "default"
  atomic          = true
  cleanup_on_fail = true

  # Set values for the Redis Helm chart based on the provided configuration
  values = [
    <<-EOT
        architecture: "standalone"
        fullNameOverride: "afid-redis"
        master:
            service:
                ports:
                    redis: 6379
        auth:
            enabled: False
    EOT
  ]

  # Timeout for Helm operations
  timeout = 600
  wait    = true
}
