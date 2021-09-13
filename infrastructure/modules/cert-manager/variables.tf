variable "namespace" {
  type        = string
  default     = "cert-manager"
  description = "Namespace to install Cert Manager in"
}

variable "create_namespace" {
  type        = bool
  default     = true
  description = "Controls if a namespace should be created"
}

variable "chart_version" {
  type        = string
  default     = "v1.5.3"
  description = "Helm chart version"
}

variable "create_cluster_issuer" {
  type        = bool
  default     = true
  description = "Controls whether a default cluster issuer should be created"
}
