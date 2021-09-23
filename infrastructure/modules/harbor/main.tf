locals {
  namespace = var.create_namespace ? element(concat(kubernetes_namespace.this.*.metadata.0.name, [""]), 0) : var.namespace

  cert_secret_name = "cert-harbor"
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

resource "k8s_manifest" "cert" {
  namespace = local.namespace

  content = <<EOF
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: harbor
spec:
  secretName: ${local.cert_secret_name}
  dnsNames:
    - "*.${var.base_domain}"
  issuerRef:
    kind: ClusterIssuer
    name: ${var.cluster_issuer}
EOF
}

# resource "kubernetes_manifest" "cert" {
#   manifest = {
#     "apiVersion" = "cert-manager.io/v1"
#     "kind"       = "Certificate"
#     "metadata" = {
#       "name"      = "harbor"
#       "namespace" = local.namespace
#     }
#     "spec" = {
#       "secretName" : "${local.cert_secret_name}"
#       "dnsNames" : [
#         "*.${local.domain}"
#       ],
#       "issuerRef" = {
#         "name" = var.cluster_issuer
#         "kind" = "ClusterIssuer"
#       }
#     }
#   }
# }

resource "random_string" "admin_password" {
  length  = 8
  special = false
}

resource "kubernetes_secret" "admin_password" {
  metadata {
    name      = "harbor-admin-password"
    namespace = local.namespace
  }

  data = {
    secret = random_string.admin_password.result
  }
}
