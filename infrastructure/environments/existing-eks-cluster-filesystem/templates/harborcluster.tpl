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
  portal: {}
  registry:
    replicas: 1
    metrics:
      enabled: true
  core:
    replicas: 3
    tokenIssuer:
      name: ca
      kind: ClusterIssuer
    metrics:
      enabled: false
    log:
      level: debug
  chartmuseum: {}
  exporter: {}
  trivy:
    skipUpdate: false
    storage: {}
  notary:
    migrationEnabled: true
  database:
    kind: "Zlando/PostgreSQL"
    spec:
      zlandoPostgreSql:
        operatorVersion: "1.5.0"
        storage: 20Gi
        replicas: 1
        resources:
          limits:
            cpu: 5000m
            memory: 2500Mi
          requests:
            cpu: 1000m
            memory: 2500Mi
  cache:
    kind: RedisFailover
    spec:
      redisFailover:
        operatorVersion: "1.0"
        sentinel:
          replicas: 1
        server:
          replicas: 1
  storage:
    kind: "FileSystem"
    spec:
      fileSystem:
        chartPersistentVolume:
          claimName: harbor-chart
        registryPersistentVolume:
          claimName: harbor-registry
