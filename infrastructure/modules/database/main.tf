module "this" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 5.2"

  name           = var.name
  engine         = "aurora-postgresql"
  engine_version = "13.3"
  instance_type  = var.instance_type

  vpc_id                = var.vpc_id
  db_subnet_group_name  = var.subnet_group_name
  create_security_group = true
  allowed_cidr_blocks   = ["0.0.0.0/0"]

  replica_count          = 1
  create_random_password = true
  publicly_accessible    = true

  apply_immediately   = true
  skip_final_snapshot = true

  enabled_cloudwatch_logs_exports = ["postgresql"]
}

provider "postgresql" {
  host     = module.this.rds_cluster_endpoint
  port     = module.this.rds_cluster_port == "" ? 0 : module.this.rds_cluster_port
  username = module.this.rds_cluster_master_username
  password = module.this.rds_cluster_master_password
}

resource "postgresql_database" "core" {
  name = "core"

  # Make sure this resource is destroyed first
  depends_on = [
    module.this
  ]
}

resource "postgresql_database" "notaryserver" {
  name = "notaryserver"

  # Make sure this resource is destroyed first
  depends_on = [
    module.this
  ]
}

resource "postgresql_database" "notarysigner" {
  name = "notarysigner"

  # Make sure this resource is destroyed first
  depends_on = [
    module.this
  ]
}

resource "kubernetes_secret" "password" {
  metadata {
    name      = "harbor-database-password"
    namespace = var.harbor_namespace
  }

  data = {
    postgresql-password = module.this.rds_cluster_master_password
  }

  type = "goharbor.io/postgresql"
}
