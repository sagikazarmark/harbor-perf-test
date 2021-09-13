locals {
  namespace = var.create_namespace ? element(concat(kubernetes_namespace.this.*.metadata.0.name, [""]), 0) : var.namespace

  create_public_zone = var.parent_zone_id != ""
  domain             = local.create_public_zone ? "${var.name}.${trimsuffix(element(concat(data.aws_route53_zone.parent.*.name, [""]), 0), ".")}" : "${var.name}.com"
  zone_arn           = local.create_public_zone ? element(concat(aws_route53_zone.public.*.arn, [""]), 0) : element(concat(aws_route53_zone.private.*.arn, [""]), 0)

  access_key_id     = var.create_iam ? element(concat(aws_iam_access_key.this.*.id, [""]), 0) : var.access_key_id
  secret_access_key = var.create_iam ? element(concat(aws_iam_access_key.this.*.secret, [""]), 0) : var.secret_access_key
}

data "aws_route53_zone" "parent" {
  count = local.create_public_zone ? 1 : 0

  zone_id = var.parent_zone_id
}

resource "aws_route53_record" "public_ns" {
  count = local.create_public_zone ? 1 : 0

  zone_id = element(concat(data.aws_route53_zone.parent.*.zone_id, [""]), 0)
  name    = local.domain
  type    = "NS"
  ttl     = "300"
  records = element(concat(aws_route53_zone.public.*.name_servers, [[]]), 0)
}

resource "aws_route53_zone" "public" {
  count = local.create_public_zone ? 1 : 0

  name = local.domain

  force_destroy = true
}

resource "aws_route53_zone" "private" {
  count = local.create_public_zone ? 0 : 1

  name = local.domain

  force_destroy = true

  vpc {
    vpc_id = var.vpc_id
  }
}

resource "aws_iam_policy" "this" {
  count = var.create_iam ? 1 : 0

  name = "${var.name}-external-dns"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "route53:ChangeResourceRecordSets"
      ],
      "Resource": [
        "${local.zone_arn}"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "route53:ListHostedZones",
        "route53:ListResourceRecordSets"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_user" "this" {
  count = var.create_iam ? 1 : 0

  name = "${var.name}-external-dns"
}

resource "aws_iam_user_policy_attachment" "this" {
  count = var.create_iam ? 1 : 0

  user       = element(concat(aws_iam_user.this.*.name, [""]), 0)
  policy_arn = element(concat(aws_iam_policy.this.*.arn, [""]), 0)
}

resource "aws_iam_access_key" "this" {
  count = var.create_iam ? 1 : 0

  user = element(concat(aws_iam_user.this.*.name, [""]), 0)
}

resource "kubernetes_namespace" "this" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name = var.namespace

    labels = {
      name = var.namespace
    }
  }
}

data "aws_region" "current" {}

resource "helm_release" "this" {
  name       = "external-dns"
  chart      = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  namespace  = local.namespace

  version = var.chart_version

  set {
    name  = "provider"
    value = "aws"
  }

  set {
    name  = "policy"
    value = "upsert-only"
  }

  set {
    name  = "domainFilters"
    value = "{${local.domain}}"
  }

  set {
    name  = "txtOwnerId"
    value = var.name
  }

  set {
    name  = "aws.region"
    value = data.aws_region.current.name
  }

  set {
    name  = "aws.credentials.accessKey"
    value = local.access_key_id
  }

  set {
    name  = "aws.credentials.secretKey"
    value = local.secret_access_key
  }
}
