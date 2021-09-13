variable "name" {
  type        = string
  description = "A DNS-compatible base name used for creating various resources"
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "AWS VPC ID (required when no parent zone is provided)"
}

variable "parent_zone_id" {
  type        = string
  default     = ""
  description = "Used for creating a public hosted zone in a (public) parent zone. Otherwise a private zone is created."
}

variable "create_iam" {
  type        = bool
  default     = true
  description = "Create IAM resources for External DNS"
}

variable "access_key_id" {
  type        = string
  default     = ""
  description = "AWS Access Key ID (required when IAM resource creation is disabled)"
}

variable "secret_access_key" {
  type        = string
  default     = ""
  description = "AWS Secret Access Key (required when IAM resource creation is disabled)"
}

variable "namespace" {
  type        = string
  default     = "external-dns"
  description = "Namespace to install External DNS in"
}

variable "create_namespace" {
  type        = bool
  default     = true
  description = "Controls if a namespace should be created"
}

variable "chart_version" {
  type        = string
  default     = "5.4.5"
  description = "Helm chart version"
}
