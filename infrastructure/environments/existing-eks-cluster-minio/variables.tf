variable "name" {
  type        = string
  description = "Environment name"
}

variable "region" {
  type        = string
  description = "AWS region to launch the infrastructure in"
}

variable "cluster_id" {
  type        = string
  description = "EKS cluster ID"
}

variable "enable_ingress" {
  type        = bool
  default     = true
  description = "Set to false to disable installing an ingress controller"
}

variable "parent_zone_id" {
  type        = string
  description = "Hosted Zone ID for creating DNS records for the test environment"
}

variable "executor_subnet_range" {
  type        = string
  description = "Executor subnet CIDR range"
}

variable "executor_route_table_id" {
  type        = string
  description = "Executor subnet route table ID"
}

variable "executor_key_name" {
  type        = string
  description = "Executor EC2 SSH key name"
}
