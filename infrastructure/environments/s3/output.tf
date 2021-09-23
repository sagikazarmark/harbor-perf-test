output "harbor_url" {
  value = "https://${module.testbed.harbor_domain}"
}

output "harbor_user" {
  value = "admin"
}

output "harbor_password" {
  value     = module.testbed.harbor_admin_password
  sensitive = true
}

output "executor_ip" {
  value = module.testbed.executor_ip
}
