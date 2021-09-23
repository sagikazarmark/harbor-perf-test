variable "name" {
  type        = string
  description = "A DNS-compatible base name used for creating various resources"
}

variable "vpc_id" {
  type = string
}

variable "subnet_group_name" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "cache.m5.large"
}

variable "security_group_id" {
  type = string
}

variable "harbor_namespace" {
  type = string
}
