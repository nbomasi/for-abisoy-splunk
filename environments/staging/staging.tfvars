aws_region = "us-east-1"
ami_owner = "938106001005"
ami_name_filter = "packer-cis-hardened-ami-*"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
cidr_block = "178.32.0.0/16"
enable_dns_support = true
enable_dns_hostnames = true
environment = "staging"
instance_type = "t2.micro"
instance_count = 2
key_name = "podb"
pod = "Pod-B"
preferred_number_of_private_subnets = 2
preferred_number_of_public_subnets = 2
root_volume_size = 30
root_volume_type = "gp3"
aws_account_id = "938106001005"
amazon_side_asn = 64512
user_name = "devops-pod-b-terraform-staging"
bucket_name = "devops-pod-b-bucket-staging"
dynamodb_table_name = "devops-pod-b-dynamodb-staging"
role_name           = "devops-pod-b-role-staging"
s3-policy_name      = "devops-pod-b-s3-policy-staging"
dynamodb-policy_name = "devops-pod-b-dynamodb-policy-staging"
state_file_key      = "${var.environment}/terraform.tfstate"
internal            = "false"
load_balancer_type  = "application"
alb_name            = "devops-pod-b-alb-staging"
vpc_id              = "aws_vpc.main.id"

ingress_rules = [
 {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
]

default_tags = {
  ManagedBy = "Terraform"
  Environment = "Staging"
}
vpc_security_groups = ["80", "8080", "22", "3306"]

use_asg = false
asg_min_size = 1
asg_max_size = 3
asg_desired_capacity = 1
