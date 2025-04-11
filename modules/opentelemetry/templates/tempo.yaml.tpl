stream_over_http_enabled: true
server:
  http_listen_port: 3200
  log_level: info

query_frontend:
  search:
    duration_slo: 5s
    throughput_bytes_slo: 1.073741824e+09
    metadata_slo:
      duration_slo: 5s
      throughput_bytes_slo: 1.073741824e+09
  trace_by_id:
    duration_slo: 5s

distributor:
  receivers: 
    otlp:
      protocols:
        http:
        grpc:

ingester:
  max_block_duration: 12h 

compactor:
  compaction:
    block_retention: 12h 

storage:
    trace:
        backend: s3
        s3:
        bucket: ${bucket_name}
        endpoint: ${endpoint}
        region: ${region}
        access_key: ${access_key}
        secret_key: ${secret_key}
        insecure: false

overrides:
  defaults:
    metrics_generator:
      processors: [service-graphs, span-metrics, local-blocks] # enables metrics generator
      generate_native_histograms: both
    global:
      max_bytes_per_trace: 50000000 # 50MB per trace
