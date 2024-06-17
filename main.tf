terraform {
  required_version = ">= 0.12"
}

module "vpc" {
  source                = "./modules/vpc"

  cidr_block            = var.cidr_block
  enable_dns_support    = var.enable_dns_support
  enable_dns_hostnames  = var.enable_dns_hostnames
  vpc_name              = "devops-${var.pod}-${local.timestamp}-${var.environment}-vpc"
  tags                  = var.tags
}

locals {
  timestamp = formatdate("YYYYMM", timestamp())
}
