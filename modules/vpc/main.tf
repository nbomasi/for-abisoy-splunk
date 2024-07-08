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

# Get list of availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public" {
  count             = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    var.tags,
    {
      Name = format("devops-%s-%s-%s-public-subnet-%d", var.pod, local.timestamp, var.environment, count.index + 1)
    },
  )
}

resource "aws_subnet" "private" {
  count             = var.preferred_number_of_private_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone =  data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]

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
