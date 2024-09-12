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



locals {
  timestamp = formatdate("YYYYMM", timestamp())
}
