output "host" {
  value = module.this.endpoint
}

output "port" {
  value = module.this.port
}

output "auth_token" {
  value = random_string.auth_token.result
}

output "secret" {
  value = kubernetes_secret.password.metadata.0.name
}
