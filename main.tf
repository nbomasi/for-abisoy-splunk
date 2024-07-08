terraform {
  required_version = ">= 0.12"
}

module "vpc" {
  source                              = "./modules/vpc"
  cidr_block                          = var.cidr_block
  enable_dns_support                  = var.enable_dns_support
  enable_dns_hostnames                = var.enable_dns_hostnames
  public_subnet_cidrs                 = [for i in range(2, 5, 2) : cidrsubnet(var.cidr_block, 8, i)]
  private_subnet_cidrs                = [for i in range(1, 8, 2) : cidrsubnet(var.cidr_block, 8, i)]
  preferred_number_of_private_subnets = var.preferred_number_of_private_subnets
  preferred_number_of_public_subnets  = var.preferred_number_of_public_subnets
  pod                                 = var.pod
  availability_zones                  = var.availability_zones
  environment                         = var.environment
  tags                                = var.default_tags
}

module "ec2_instance" {
  source              = "./modules/ec2"
  instance_count      = var.instance_count
  instance_type       = var.instance_type
  key_name            = var.key_name
  subnet_ids          = module.vpc.public_subnet_ids
  vpc_security_groups = var.vpc_security_groups
  ami_name_filter     = var.ami_name_filter
  ami_owner           = var.ami_owner
  pod                 = var.pod
  root_volume_size    = var.root_volume_size
  root_volume_type    = var.root_volume_type
  environment         = var.environment
  tags                = var.default_tags
  vpc_id              = module.vpc.vpc_id
}

