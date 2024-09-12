aws_region                          = "us-east-1"
ami_owner                           = "938106001005"
ami_name_filter                     = "packer-cis-hardened-ami-*"
availability_zones                  = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
cidr_block                          = "172.16.0.0/16"
enable_dns_support                  = true
enable_dns_hostnames                = true
environment                         = "sandbox"
instance_type                       = "t2.micro"
instance_count                      = 2
key_name                            = "podb"
pod                                 = "Pod-B"
preferred_number_of_private_subnets = 2
preferred_number_of_public_subnets  = 2
root_volume_size                    = 30
root_volume_type                    = "gp3"
aws_account_id                      = "938106001005"
amazon_side_asn                     = 64512
user_name                           = "devops-pod-b-terraform-sandbox"
bucket_name                         = "devops-pod-b-bucket-sandbox"
dynamodb_table_name                 = "devops-pod-b-dynamodb-sandbox"
role_name                           = "devops-pod-b-role-sandbox"
s3-policy_name                      = "devops-pod-b-s3-policy-sandbox"
dynamodb-policy_name                = "devops-pod-b-dynamodb-policy-sandbox"
state_file_key                      = "${var.environment}/terraform.tfstate"
internal                            = "false"
alb_name                            = "devops-pod-b-alb-sandbox"
nlb_name                            = "devops-pod-b-nlb-sandbox"
vpc_id                              = "aws_vpc.main.id"

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
  ManagedBy   = "Terraform"
  Environment = "Sandbox"
}
vpc_security_groups = ["80", "8080", "22", "3306"]

use_asg              = true
asg_min_size         = 1
asg_max_size         = 3
asg_desired_capacity = 1

 # ASG Configuration
instance-type        = "t3.medium"
asg-min-size         = 1
asg-max-size         = 5
asg-desired-capacity = 1                              # Replace with your key pair name

# Additional configurations
root-volume-size  = 20
root-volume-type  = "gp2"
health-check-type = "EC2"