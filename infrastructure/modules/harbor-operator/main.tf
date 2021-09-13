locals {
  namespace = var.create_namespace ? element(concat(kubernetes_namespace.this.*.metadata.0.name, [""]), 0) : var.namespace
}

resource "kubernetes_namespace" "this" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name = var.namespace

    labels = {
      name = var.namespace
    }
  }
}

resource "helm_release" "this" {
  name      = "harbor-operator"
  chart     = "https://github.com/goharbor/harbor-operator/releases/download/${var.chart_version}/harbor-operator-${var.chart_version}.tgz"
  namespace = local.namespace

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "image.tag"
    value = var.chart_version
  }

  set {
    name  = "minio-operator.enabled"
    value = "true"
  }

  set {
    name  = "minio-operator.env.MINIO_OPERATOR_TLS_ENABLE"
    value = "off"
  }

  set {
    name  = "postgres-operator.enabled"
    value = "true"
  }

  set {
    name  = "redisoperator.enabled"
    value = "true"
  }
}
