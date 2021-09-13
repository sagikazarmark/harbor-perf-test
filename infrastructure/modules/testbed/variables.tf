variable "name" {
  type        = string
  description = "Test instance name"
}

variable "kubernetes_version" {
  type    = string
  default = "1.21"
}

variable "eks_node_instance_type" {
  type        = string
  default     = "c5.2xlarge"
  description = "Kubernetes node EC2 instance type"
}

variable "eks_node_group_size" {
  type        = number
  default     = 5
  description = "Kubernetes node group size"
}

variable "ingress_chart_version" {
  type        = string
  default     = "4.0.1"
}

variable "external_dns_chart_version" {
  type        = string
  default     = "5.4.5"
}

variable "cert_manager_chart_version" {
  type        = string
  default     = "v1.5.3"
}

variable "harbor_operator_chart_version" {
  type        = string
  default     = "v1.1.0"
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
  default = "837343e"
}
