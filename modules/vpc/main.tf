resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    var.tags,
    {
      Name = format("devops-%s-%s-%s-vpc", var.pod, local.timestamp, var.environment)
    },
  )
}

resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = merge(
    var.tags,
    {
      Name = format("devops-%s-%s-%s-public-subnet-%d", var.pod, local.timestamp, var.environment, count.index + 1)
    },
  )
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = merge(
    var.tags,
    {
      Name = format("devops-%s-%s-%s-private-subnet-%d", var.pod, local.timestamp, var.environment, count.index + 1)
    },
  )
}

locals {
  timestamp = formatdate("YYYYMM", timestamp())
}
