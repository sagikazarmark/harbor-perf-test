variable "name" {
  type        = string
  description = "A DNS-compatible base name used for creating various resources"
}

variable "vpc_id" {
  type        = string
  description = "AWS VPC ID"
}

variable "subnet_id" {
  type        = string
  default     = ""
  description = "A public AWS Subnet ID that attaches a public IP to the instance"
}

variable "instance_type" {
  type        = string
  default     = "m5.4xlarge"
  description = "EC2 instance type"
}

variable "key_name" {
  type        = string
  default     = ""
  description = "EC2 SSH key name"
}

variable "go_version" {
  type    = string
  default = "1.17"
}

variable "k6_version" {
  type    = string
  default = "456a01b"
}

variable "harbor_scheme" {
  type        = string
  default     = "https"
  description = "Harbor HTTP scheme"
}

variable "harbor_host" {
  type        = string
  description = "Harbor hostname"
}

variable "harbor_user" {
  type        = string
  default     = "admin"
  description = "Harbor user"
}

variable "harbor_password" {
  type        = string
  description = "Harbor password"
}

variable "harbor_size" {
  type        = string
  default     = "small"
  description = "Harbor installation size"
}
