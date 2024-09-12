resource "aws_vpc" "main" {
  cidr_block                       = var.cidr_block
  enable_dns_support               = var.enable_dns_support
  enable_dns_hostnames             = var.enable_dns_hostnames
  assign_generated_ipv6_cidr_block = true

  tags = merge(
    var.tags,
    {
      Name = format("devops-%s-%s-%s-vpc", var.pod, local.timestamp, var.environment)
    },
  )
}


# Create an Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = format("devops-%s-%s-%s-igw", var.pod, local.timestamp, var.environment)
    },
  )
}



# Get list of availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public" {
  count                   = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  ipv6_cidr_block         = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true # Makes the subnet public

  tags = merge(
    var.tags,
    {
      Name = format("devops-%s-%s-%s-public-subnet-%d", var.pod, local.timestamp, var.environment, count.index + 1)
    },
  )
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    var.tags,
    {
      Name = format("devops-%s-%s-%s-public-rt", var.pod, local.timestamp, var.environment)
    },
  )
}

resource "aws_subnet" "private" {
  count             = var.preferred_number_of_private_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]

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
