variable "region" {
  type        = string
  description = "AWS region to launch the infrastructure in"
}

variable "parent_zone_id" {
  type        = string
  default     = ""
  description = "Hosted Zone ID for creating DNS records for the test environment. If not provided, a private zone will be created."
}

variable "eks_kubeconfig_aws_authenticator_env_variables" {
  type        = map(string)
  default     = {}
  description = "Environment variables that should be used when executing the authenticator. e.g. { AWS_PROFILE = \"eks\"}."
}

variable "executor_key_name" {
  type        = string
  description = "Executor EC2 SSH key name"
}
