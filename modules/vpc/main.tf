# Create VPC
resource "aws_vpc" "main" {
  cidr_block                   = var.cidr_block
  enable_dns_support           = var.enable_dns_support
  enable_dns_hostnames         = var.enable_dns_hostnames

  tags = merge(
    var.tags,
    {
      Name = format("%s-VPC", var.vpc_name)
    },
  )
}

locals {
  timestamp = formatdate("YYYYMM", timestamp())
}

