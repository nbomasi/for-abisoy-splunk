aws_region = "us-east-1"
ami_owner = "938106001005" #Add aws Account number here
ami_name_filter = "packer-cis-hardened-ami-*"
# Example of availability zones
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
cidr_block = "172.16.0.0/16"
enable_dns_support = "true"
enable_dns_hostnames = "true"
environment = "sandbox"
instance_type = "t2.micro"
instance_count = "2"
key_name = "podb"
pod = "Pod-B"
preferred_number_of_private_subnets = "4"
preferred_number_of_public_subnets = "2"
root_volume_size = 30
root_volume_type = "gp3"
default_tags = {
  Managed-By = "Terraform"
  Environment = "Sandbox"
}
# Example of Security Groups
vpc_security_groups = ["80", "8080", "22", "3306"]
