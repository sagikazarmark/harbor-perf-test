variable "namespace" {
  type        = string
  default     = "harbor-operator"
  description = "Namespace to install Harbor Operator in"
}

variable "create_namespace" {
  type        = bool
  default     = true
  description = "Controls if a namespace should be created"
}

variable "chart_version" {
  type        = string
  default     = "v1.1.0"
  description = "Helm chart version"
}

variable "enable_postgres_operator" {
  type    = bool
  default = true
}

variable "enable_redis_operator" {
  type    = bool
  default = true
}
