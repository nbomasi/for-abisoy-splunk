terraform {
  required_version = ">= 0.12"
}

data "aws_ami" "latest_packer_ami" {
  most_recent = true
  owners      = [var.ami_owner]

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }
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
  amazon_side_asn                     = var.amazon_side_asn
  tags                                = var.default_tags
}

module "ec2_instance" {
  source               = "./modules/ec2"
  instance_count       = var.instance_count
  instance_type        = var.instance_type
  key_name             = var.key_name
  subnet_ids           = module.vpc.public_subnet_ids
  vpc_security_groups  = var.vpc_security_groups
  ami_name_filter      = var.ami_name_filter
  ami_owner            = var.ami_owner
  pod                  = var.pod
  root_volume_size     = var.root_volume_size
  root_volume_type     = var.root_volume_type
  environment          = var.environment
  tags                 = var.default_tags
  vpc_id               = module.vpc.vpc_id
  use_asg              = var.use_asg
  asg_min_size         = var.asg_min_size
  asg_max_size         = var.asg_max_size
  asg_desired_capacity = var.asg_desired_capacity
}

module "s3" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
  tags        = var.default_tags
}

module "dynamodb" {
  source = "./modules/dynamodb"

  dynamodb_table_name = var.dynamodb_table_name
  tags                = var.default_tags
}

module "iam" {
  source = "./modules/iam"

  bucket_name          = var.bucket_name
  dynamodb_table_name  = var.dynamodb_table_name
  user_name            = var.user_name
  aws_account_id       = var.aws_account_id
  role_name            = var.role_name
  s3-policy_name       = var.s3-policy_name
  dynamodb-policy_name = var.dynamodb-policy_name
}

module "alb" {
  source              = "./modules/alb" # Path to the ALB module
  alb_name            = var.alb_name
  internal            = var.internal
  vpc_id              = module.vpc.vpc_id
  subnets             = module.vpc.public_subnet_ids
  alb_security_groups = [module.alb.alb_sg_id]
  tags                = merge(var.tags, { Name = "alb" })
  ingress_rules       = var.ingress_rules
}
module "nlb" {
  source        = "./modules/nlb"
  nlb_name      = var.nlb_name
  internal      = var.internal
  subnets       = module.vpc.public_subnet_ids
  vpc_id        = module.vpc.vpc_id
  tags          = merge(var.tags, { Name = "nlb" })
  ingress_rules = var.ingress_rules
  environment = var.environment

  enable_deletion_protection = false

}

data "aws_lb" "alb" {
  arn = module.alb.alb_arn
}

module "aws_route53_zone" {
  source      = "./modules/route53"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
  pod         = var.pod
  alb_arn     = module.alb.alb_arn
  alias_records = [
    {
      name                   = module.aws_route53_zone.zone_name
      zone_id                = data.aws_lb.alb.zone_id
      evaluate_target_health = true
      alias_name             = data.aws_lb.alb.dns_name

    }
  ]

}

module "alb-nlb" {
  source      = "./modules/alb-nlb"
  vpc_id      = module.vpc.vpc_id
  subnets     = module.vpc.public_subnet_ids
  environment = var.environment
}

module "prometheus_grafana_asg" {
  source = "./modules/asg"

  vpc-id               = module.vpc.vpc_id                 # Replace with your VPC ID
  subnet-ids           = module.vpc.public_subnet_ids      # Replace with your subnet IDs
  ami-id               = data.aws_ami.latest_packer_ami.id # Replace with the AMI ID 
  asg-desired-capacity = var.asg-desired-capacity
  asg-max-size         = var.asg-max-size # Ensure this is set appropriately
  health-check-type    = var.health-check-type
  instance-type        = var.instance-type
  root-volume-size     = var.root-volume-size
  root-volume-type     = var.root-volume-type
  asg-min-size         = var.asg-min-size
  ami_owner            = var.ami_owner
  ami_name_filter      = var.ami_name_filter
  environment          = var.environment
  target_group_arns    = module.nlb.splunk_indexer_tg_arns

}
