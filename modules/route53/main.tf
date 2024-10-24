# Create the internal hosted zone for the "timedelta.internal" domain

resource "aws_route53_zone" "internal_zone" {
  name = var.environment == "production" ? "timedelta.internal" : "${var.environment}.timedelta.internal"
  vpc {
    vpc_id = var.vpc_id
  }
  tags = {
    Name = format("devops-%s-%s-aws_route53_zone-%s", var.pod, local.timestamp, var.environment)
  }
}

data "aws_lb" "alb" {
  arn = var.alb_arn
}


locals {
  timestamp = formatdate("YYYYMM", timestamp())


  alias_records = [
    for record in var.alias_records : {
      name                   = record.name
      zone_id                = record.zone_id
      evaluate_target_health = record.evaluate_target_health
      alias_name             = record.alias_name
    }
  ]
}


resource "aws_route53_record" "alias_internal_record" {
  for_each = { for record in local.alias_records : record.name => record }

  zone_id = aws_route53_zone.internal_zone.zone_id
  name    = "www.${aws_route53_zone.internal_zone.name}"
  type    = "A"

  alias {
    name                   = each.value.alias_name
    zone_id                = each.value.zone_id
    evaluate_target_health = each.value.evaluate_target_health
  }
}


resource "aws_route53_zone" "squid-proxy_zone" {
  name = var.environment == "production" ? "proxy.timedelta.internal" : "proxy.${var.environment}.timedelta.internal"
  vpc {
    vpc_id = var.vpc_id
  }
  tags = {
    Name = format("devops-%s-%s-squid-proxy_route53_zone-%s", var.pod, local.timestamp, var.environment)
  }
}