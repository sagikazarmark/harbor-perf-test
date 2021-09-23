output "host" {
  value = module.this.rds_cluster_endpoint
}

output "port" {
  value = module.this.rds_cluster_port
}

output "username" {
  value = module.this.rds_cluster_master_username
}

output "password" {
  value = module.this.rds_cluster_master_password
}

output "secret" {
  value = kubernetes_secret.password.metadata.0.name
}
