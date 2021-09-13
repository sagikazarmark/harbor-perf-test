output "kubernetes_endpoint" {
  value     = data.aws_eks_cluster.cluster.endpoint
  sensitive = true
}

output "kubernetes_ca" {
  value     = data.aws_eks_cluster.cluster.certificate_authority.0.data
  sensitive = true
}

output "kubernetes_token" {
  value     = data.aws_eks_cluster_auth.cluster.token
  sensitive = true
}

output "name" {
  value = local.name
}

output "domain" {
  value = module.external_dns.domain
}

output "harbor_domain" {
  value = "core.${module.external_dns.domain}"
}


output "harbor_namespace" {
  value = module.harbor.namespace
}

output "harbor_admin_secret" {
  value = module.harbor.admin_password_secret
}

output "harbor_cert_secret" {
  value = module.harbor.cert_secret
}

output "executor_ip" {
  value = module.executor.public_ip
}
