data "aws_ami" "latest_packer_ami" {
  most_recent = true
  owners      = [var.ami_owner]

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }
}

# ASG Configuration
instance-type        = "t3.medium"
asg-min-size         = 1
asg-max-size         = 5
asg-desired-capacity = 1                              # Replace with your key pair name
vpc-id               = module.vpc.vpc_id              # Replace with your VPC ID
subnet-ids           = [module.vpc.public_subnet_ids] # Replace with your subnet IDs

# AMI IDs for Prometheus and Grafana
ami-id = data.aws_ami.latest_packer_ami # Replace with the AMI ID 

# Additional configurations
root-volume-size  = 20
root-volume-type  = "gp2"
health-check-type = "EC2"



