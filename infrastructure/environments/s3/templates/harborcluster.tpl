apiVersion: goharbor.io/v1beta1
kind: HarborCluster
metadata:
  name: harbor
spec:
  version: "${harbor_version}"
  logLevel: debug
  harborAdminPasswordRef: ${admin_secret}
  externalURL: https://${core_domain}
  expose:
    core:
      ingress:
        annotations:
          ingress.kubernetes.io/proxy-body-size: "0"
          nginx.ingress.kubernetes.io/proxy-body-size: "0"
        host: ${core_domain}
      tls:
        certificateRef: ${cert_secret}
    notary:
      ingress:
        host: notary.${base_domain}
      tls:
        certificateRef: ${cert_secret}
  internalTLS:
    enabled: true
  portal:
    nodeSelector:
      role: test

    tolerations:
      - key: "role"
        operator: "Equal"
        value: "test"
        effect: "NoSchedule"
  registry:
    replicas: 3
    metrics:
      enabled: true

    nodeSelector:
      role: test

    tolerations:
      - key: "role"
        operator: "Equal"
        value: "test"
        effect: "NoSchedule"
  core:
    replicas: 3
    tokenIssuer:
      name: ca
      kind: ClusterIssuer
    metrics:
      enabled: false
    log:
      level: debug

    nodeSelector:
      role: test

    tolerations:
      - key: "role"
        operator: "Equal"
        value: "test"
        effect: "NoSchedule"
  chartmuseum:
    nodeSelector:
      role: test

    tolerations:
      - key: "role"
        operator: "Equal"
        value: "test"
        effect: "NoSchedule"
  exporter:
    nodeSelector:
      role: test

    tolerations:
      - key: "role"
        operator: "Equal"
        value: "test"
        effect: "NoSchedule"
  trivy:
    skipUpdate: false
    storage: {}

    nodeSelector:
      role: test

    tolerations:
      - key: "role"
        operator: "Equal"
        value: "test"
        effect: "NoSchedule"
  notary:
    migrationEnabled: true

    server:
      nodeSelector:
        role: test

      tolerations:
        - key: "role"
          operator: "Equal"
          value: "test"
          effect: "NoSchedule"

    signer:
      nodeSelector:
        role: test

      tolerations:
        - key: "role"
          operator: "Equal"
          value: "test"
          effect: "NoSchedule"
  database:
    kind: PostgreSQL
    spec:
      postgresql:
        username: ${database_username}
        passwordRef: ${database_secret}
        hosts:
          - host: ${database_host}
            port: ${database_port}
  cache:
    kind: Redis
    spec:
      redis:
        host: ${cache_host}
        port: ${cache_port}
  storage:
    kind: "S3"
    spec:
      s3:
        accesskey: ${s3_access_key}
        secretkeyRef: ${s3_secret}
        region: ${s3_region}
        bucket: ${s3_bucket}
