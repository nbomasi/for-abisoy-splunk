terraform {
  required_version = ">= 0.12"
}

module "vpc" {
  source               = "./modules/vpc"
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  pod                  = var.pod
  environment          = var.environment
  tags                 = var.tags
}

module "ec2_instance" {
  source                 = "./modules/ec2"
  instance_count         = var.instance_count
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_ids             = module.vpc.public_subnet_ids
  vpc_security_group_ids = var.vpc_security_group_ids
  ami_name_filter        = var.ami_name_filter
  ami_owner              = var.ami_owner
  pod                    = var.pod
  environment            = var.environment
  tags                   = var.tags
}

