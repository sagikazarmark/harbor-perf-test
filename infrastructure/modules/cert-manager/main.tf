locals {
  namespace = var.create_namespace ? element(concat(kubernetes_namespace.this.*.metadata.0.name, [""]), 0) : var.namespace

  cluster_issuer_name = "ca"
}

resource "kubernetes_namespace" "this" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name = var.namespace

    labels = {
      name                                 = var.namespace
      "cert-manager.io/disable-validation" = "true"
    }
  }
}

resource "helm_release" "this" {
  name       = "cert-manager"
  chart      = "cert-manager"
  repository = "https://charts.jetstack.io"
  namespace  = local.namespace

  version = var.chart_version
  timeout = 300
  wait    = true

  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "tls_private_key" "ca" {
  count = var.create_cluster_issuer ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "ca" {
  count = var.create_cluster_issuer ? 1 : 0

  key_algorithm     = element(concat(tls_private_key.ca.*.algorithm, [""]), 0)
  private_key_pem   = element(concat(tls_private_key.ca.*.private_key_pem, [""]), 0)
  is_ca_certificate = true

  subject {
    common_name  = "example.com"
    organization = "ACME Examples, Inc"
  }

  validity_period_hours = 8760

  allowed_uses = [
    "cert_signing",
    "key_encipherment",
    "digital_signature",
  ]
}

resource "kubernetes_secret" "cluster_issuer" {
  count = var.create_cluster_issuer ? 1 : 0

  metadata {
    name      = "cluster-issuer-${local.cluster_issuer_name}"
    namespace = local.namespace
  }

  data = {
    "tls.crt" = element(concat(tls_self_signed_cert.ca.*.cert_pem, [""]), 0)
    "tls.key" = element(concat(tls_private_key.ca.*.private_key_pem, [""]), 0)
  }
}

resource "k8s_manifest" "cluster_issuer" {
  count = var.create_cluster_issuer ? 1 : 0

  content = <<EOF
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: ${local.cluster_issuer_name}
spec:
  ca:
    secretName: ${element(concat(kubernetes_secret.cluster_issuer.*.metadata.0.name, [""]), 0)}
EOF

  depends_on = [
    helm_release.this
  ]
}

# resource "kubernetes_manifest" "cluster_issuer" {
#   manifest = {
#     "apiVersion" = "cert-manager.io/v1"
#     "kind"       = "ClusterIssuer"
#     "metadata" = {
#       "name" = local.cluster_issuer_name
#     }
#     "spec" = {
#       "ca" = {
#         "secretName" = element(concat(kubernetes_secret.cluster_issuer.*.metadata.0.name, [""]), 0)
#       }
#     }
#   }

#   depends_on = [
#     helm_release.this
#   ]
# }
