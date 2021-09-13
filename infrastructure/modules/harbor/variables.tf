variable "namespace" {
  type        = string
  default     = "harbor"
  description = "Namespace to install Harbor in"
}

variable "create_namespace" {
  type        = bool
  default     = true
  description = "Controls if a namespace should be created"
}

variable "base_domain" {
  type        = string
  description = "Base domain name for Harbor"
}

variable "cluster_issuer" {
  type        = string
  description = "Cluster issuer used for creating a Certificate"
}
