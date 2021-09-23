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
  default = "db.r5.2xlarge"
}

variable "harbor_namespace" {
  type = string
}
