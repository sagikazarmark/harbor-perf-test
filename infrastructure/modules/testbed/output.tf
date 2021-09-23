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

output "harbor_admin_password" {
  value     = module.harbor.admin_password
  sensitive = true
}

output "harbor_admin_secret" {
  value = module.harbor.admin_password_secret
}

output "harbor_cert_secret" {
  value = module.harbor.cert_secret
}

output "harbor_database_host" {
  value = module.database.host
}

output "harbor_database_port" {
  value = module.database.port
}

output "harbor_database_username" {
  value = module.database.username
}

output "harbor_database_secret" {
  value = module.database.secret
}

output "harbor_cache_host" {
  value = module.cache.host
}

output "harbor_cache_port" {
  value = module.cache.port
}

output "harbor_cache_secret" {
  value = module.cache.secret
}

output "executor_ip" {
  value = module.executor.public_ip
}
