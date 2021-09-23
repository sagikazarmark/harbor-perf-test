variable "name" {
  type        = string
  description = "Test instance name"
}

variable "kubernetes_version" {
  type    = string
  default = "1.21"
}

variable "eks_kubeconfig_aws_authenticator_env_variables" {
  type        = map(string)
  default     = {}
  description = "Environment variables that should be used when executing the authenticator. e.g. { AWS_PROFILE = \"eks\"}."
}

variable "eks_test_node_group_instance_type" {
  type        = string
  default     = "c5.2xlarge"
  description = "Kubernetes node EC2 instance type for the test node group"
}

variable "eks_test_node_group_size" {
  type        = number
  default     = 5
  description = "Kubernetes test node group size"
}

variable "eks_infra_node_group_instance_type" {
  type        = string
  default     = "c5.2xlarge"
  description = "Kubernetes node EC2 instance type for the infra node group"
}

variable "eks_infra_node_group_size" {
  type        = number
  default     = 3
  description = "Kubernetes infra node group size"
}

variable "ingress_chart_version" {
  type    = string
  default = "4.0.1"
}

variable "external_dns_chart_version" {
  type    = string
  default = "5.4.5"
}

variable "parent_zone_id" {
  type        = string
  default     = ""
  description = "Hosted Zone ID for creating DNS records for the test environment. If not provided, a private zone will be created."
}

variable "cert_manager_chart_version" {
  type    = string
  default = "v1.5.3"
}

variable "harbor_operator_chart_version" {
  type    = string
  default = "v1.1.0"
}

variable "database_instance_type" {
  type        = string
  default     = "db.r5.2xlarge"
  description = "Database instance type"
}

variable "cache_instance_type" {
  type    = string
  default = "cache.m5.large"
  description = "Cache instance type"
}

variable "executor_instance_type" {
  type        = string
  default     = "m5.4xlarge"
  description = "Executor EC2 instance type"
}

variable "executor_key_name" {
  type        = string
  default     = ""
  description = "Executor EC2 SSH key name"
}

variable "go_version" {
  type    = string
  default = "1.17"
}

variable "k6_version" {
  type    = string
  default = "456a01b"
}
