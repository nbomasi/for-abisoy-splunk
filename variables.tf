variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "ami_owner" {
  description = "AMI owner ID"
  type        = string
}

variable "ami_name_filter" {
  description = "Filter for AMI name"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
}

variable "environment" {
  description = "Environment (e.g., sandbox, staging, production)"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
}

variable "key_name" {
  description = "Key name for EC2 instances"
  type        = string
}

variable "pod" {
  description = "Pod identifier"
  type        = string
}

variable "preferred_number_of_private_subnets" {
  description = "Preferred number of private subnets"
  type        = number
}

variable "preferred_number_of_public_subnets" {
  description = "Preferred number of public subnets"
  type        = number
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
}

variable "root_volume_type" {
  description = "Root volume type"
  type        = string
}

variable "default_tags" {
  description = "A map of default tags to assign to resources"
  type        = map(string)
}

variable "vpc_security_groups" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "use_asg" {
  description = "Flag to toggle between standalone EC2 instance and Auto Scaling Group"
  type        = bool
  default     = false
}

variable "asg_min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "asg_desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group"
  type        = number
  default     = 1
}


variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "my-terraform-state-bucket"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "terraform-state-lock"
}

variable "user_name" {
  description = "The name of the IAM user"
  type        = string
}

variable "aws_account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "s3-policy_name" {
  description = "The name of the IAM policy"
  type        = string
}

variable "dynamodb-policy_name" {
  description = "The name of the IAM policy"
  type        = string
}

