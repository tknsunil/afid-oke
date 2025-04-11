# Values for vector Helm chart

role: Agent # Deploy as DaemonSet

extraVolumes:
  - name: "geolite"
    emptyDir: {}

extraVolumeMounts:
  - name: "geolite"
    mountPath: /geolite

initContainers:
  - name: fetch-maxmind-db
    image: "alpine:3.18"
    command: ["/bin/sh", "-c"]
    args:
      - 'apk add --no-cache wget tar && wget -q "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-City&license_key=$LICENCE_KEY&suffix=tar.gz" -O - | tar -xzvf - --strip-components=1 -C /geolite'
    env:
      - name: LICENCE_KEY
        value: ${maxmind_secret_key}
    volumeMounts:
      - name: geolite
        mountPath: /geolite

customConfig:
  data_dir: "/vector-data-dir"

  api:
    enabled: true
    address: "0.0.0.0:8686"

  enrichment_tables:
    geoip_table:
      path: /geolite/GeoLite2-City.mmdb
      type: geoip

  sources:
    afid_log:
      type: kubernetes_logs
      extra_label_selector: afid.vector.enabled=true

  transforms:
    afid_log_json:
      type: remap
      inputs:
        - afid_log
      source: |
        . = parse_json!(.message)
        .timestamp = parse_timestamp!(
            del(.timestamp),
            "%Y-%m-%dT%H:%M:%S%.fZ"
        )

    afid_log_geo:
      type: remap
      inputs:
        - afid_log_json
      source: |
        geo_data, err = get_enrichment_table_record("geoip_table", { "ip": .real_ip })

        if (err == null) {
            .latitude = geo_data.latitude
            .longitude = geo_data.longitude
        }

    afid_log_collapsed:
      type: reduce
      inputs:
        - afid_log_geo
      ends_when: '.event == "request_finished"'
      group_by:
        - request_id
      merge_strategies:
        event: retain
        user_id: retain

    afid_log_duration:
      type: remap
      inputs:
        - afid_log_collapsed
      source: |
        start_time_ms, start_err = to_unix_timestamp(.timestamp, "milliseconds")
        end_time_ms, end_err = to_unix_timestamp(.timestamp_end, "milliseconds")
        if ((start_err == null) && (end_err == null)) {
          .request_duration = end_time_ms - start_time_ms
        }

  sinks:
    loki:
      type: loki
      inputs:
        - afid_log_duration
      endpoint: "http://loki-gateway:80" # Update to match the loki gateway service name
      labels:
        application: afid
        response_code: '{{ print "{{ code}}" }}'
        level: '{{ print "{{ level}}" }}'
        actor_name: '{{ print "{{ actor_name}}" }}'
        queue_name: '{{ print "{{ queue_name}}" }}'
      encoding:
        codec: json



# tolerations: [ ... ]