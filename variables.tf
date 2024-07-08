variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
}


variable "availability_zones" {
  description = "A list of availability zones for the subnets"
  type        = list(string)
}

variable "preferred_number_of_public_subnets" {
  type        = number
  description = "Number of public subnets"
}

variable "preferred_number_of_private_subnets" {
  type        = number
  description = "Number of private subnets"
}

variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
}

variable "instance_type" {
  description = "Type of instance to launch"
  type        = string
}

variable "root_volume_size" {
  description = "Volume size of EBS"
  type        = number
}

variable "root_volume_type" {
  description = "Volume type of EBS"
  type        = string
}

variable "pod" {
  description = "Pod identifier"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "vpc_security_groups" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "ami_name_filter" {
  description = "Filter for AMI name"
  type        = string
}

variable "ami_owner" {
  description = "AMI owner ID"
  type        = string
}


variable "environment" {
  description = "Environment (e.g., sandbox, staging, production)"
  type        = string
}

variable "default_tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
}
