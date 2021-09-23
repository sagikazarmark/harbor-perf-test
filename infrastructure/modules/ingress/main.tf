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
  name       = "ingress-nginx"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  namespace  = local.namespace

  version = var.chart_version

  values = [file("${path.module}/values.yaml")]
}
