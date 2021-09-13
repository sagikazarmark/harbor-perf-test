variable "namespace" {
  type        = string
  default     = "ingress"
  description = "Namespace to install the ingress controller in"
}

variable "create_namespace" {
  type        = bool
  default     = true
  description = "Controls if a namespace should be created"
}

variable "chart_version" {
  type        = string
  default     = "4.0.1"
  description = "Helm chart version"
}
