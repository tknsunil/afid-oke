# Values for loki Helm chart

deploymentMode: SingleBinary

loki:
  auth_enabled: false

  commonConfig:
    replication_factor: 1

  storage:
    type: s3
    bucketNames:
      chunks: ${loki_s3_bucket_chunks}
      ruler:  ${loki_s3_bucket_ruler}
      admin:  ${loki_s3_bucket_admin}
    s3:
      endpoint:         ${loki_s3_endpoint}
      region:           ${loki_s3_region}
      s3ForcePathStyle: true
      secretAccessKey:  ${loki_s3_secret_key}
      accessKeyId:      ${loki_s3_access_key}

  compactor:
    retention_delete_delay: "2h"

  limits_config:
    retention_period: ${loki_retention_period}
    # Adjust other limits based on expected load
    # ingestion_rate_mb: 15
    # ingestion_burst_size_mb: 30

singleBinary:
  replicas: ${loki_replicas}
  extraArgs:
    - "-config.expand-env=true"
  # persistence:
  #   enabled: true
  #   size: "10Gi"

gateway:
  enabled: true
  replicas: 1
  # service:
  #   type: ClusterIP
  #   port: 80

# Disable components not needed in singleBinary mode
ingester: { enabled: false }
querier: { enabled: false }
queryFrontend: { enabled: false }
tableManager: { enabled: false }
compactor: { enabled: false }
distributor: { enabled: false }
ruler: { enabled: false }

# loki.resources: { ... }
# gateway.resources: { ... }