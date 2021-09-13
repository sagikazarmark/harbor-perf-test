output "namespace" {
  value = local.namespace
}

output "cert_secret" {
  value = local.cert_secret_name
}

output "admin_password" {
  value     = random_string.admin_password.result
  sensitive = true
}

output "admin_password_secret" {
  value = kubernetes_secret.admin_password.metadata.0.name
}
