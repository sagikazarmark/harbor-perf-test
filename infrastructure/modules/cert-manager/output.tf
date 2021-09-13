output "cluster_issuer" {
  value = var.create_cluster_issuer ? try(yamldecode(element(concat(k8s_manifest.cluster_issuer.*.content, [""]), 0)).metadata.name, "") : ""
}
