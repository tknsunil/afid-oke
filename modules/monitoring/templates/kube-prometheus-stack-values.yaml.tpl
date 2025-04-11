grafana:
  additionalDataSources:
    - name: Loki
      type: loki
      access: proxy
      url: http://loki-gateway.monitoring.svc.cluster.local:80

    - name: Tempo
      type: tempo
      access: proxy
      orgId: 1
      url: "http://afid-tempo.monitoring.svc.cluster.local:3100"
      basicAuth: false
      isDefault: false
      version: 1
      editable: false
      apiVersion: 1
      uid: tempo

  grafana.ini:
    server:
      domain: ""
      root_url: "https://%(domain)s"
    auth.github:
      enabled: true
      allow_sign_up: true
      auto_login: false
      client_id: ${grafana_github_oauth_client_id}
      client_secret: ${grafana_github_oauth_client_secret}
      scopes: "user:email,read:org"
      auth_url: "https://github.com/login/oauth/authorize"
      token_url: "https://github.com/login/oauth/access_token"
      api_url: "https://api.github.com/user"
      allowed_organizations: AutomatedFishID
      role_attribute_path: "true||'Editor'"



# Configure Prometheus
prometheus:
  prometheusSpec:
    retention: ${prometheus_retention}
    storageSpec:
      volumeClaimTemplate:
        spec:
          accessModes: ["ReadWriteOnce"]
          resources:
            requests:
              storage: ${prometheus_storage_size}
    # Important for dynamic discovery using ServiceMonitor/PodMonitor CRDs
    podMonitorSelectorNilUsesHelmValues: false
    serviceMonitorSelectorNilUsesHelmValues: false
    # PodDisruptionBudget configuration
    podDisruptionBudget:
      enabled: true
      minAvailable: "50%" # Using minAvailable is generally preferred
      resources:
        requests: { cpu = "500m", memory = "2Gi" }
        limits: { cpu = "1000m", memory = "4Gi" }

nodeExporter: {}

kubeStateMetrics: {}

prometheusOperator:
  prometheusConfigReloader: {}

