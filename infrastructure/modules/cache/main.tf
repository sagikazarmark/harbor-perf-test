resource "random_string" "auth_token" {
  length  = 20
  special = false
}

module "this" {
  source  = "cloudposse/elasticache-redis/aws"
  version = "~> 0.40"

  name                          = var.name
  vpc_id                        = var.vpc_id
  elasticache_subnet_group_name = var.subnet_group_name
  instance_type                 = var.instance_type
  apply_immediately             = true
  automatic_failover_enabled    = false
  engine_version                = "6.x"
  family                        = "redis6.x"
  transit_encryption_enabled    = false

  #auth_token = random_string.auth_token.result

  security_group_rules = [
    {
      type                     = "egress"
      from_port                = 0
      to_port                  = 65535
      protocol                 = "-1"
      cidr_blocks              = ["0.0.0.0/0"]
      source_security_group_id = null
      description              = "Allow all outbound traffic"
    },
    {
      type        = "ingress"
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
      cidr_blocks = []
      #cidr_blocks              = var.source_subnets
      #source_security_group_id = null
      source_security_group_id = var.security_group_id
      description              = "Allow all inbound traffic from trusted Security Groups"
    },
  ]
}

resource "kubernetes_secret" "password" {
  metadata {
    name      = "harbor-cache-password"
    namespace = var.harbor_namespace
  }

  data = {
    redis-password = random_string.auth_token.result
  }

  type = "goharbor.io/redis"
}
