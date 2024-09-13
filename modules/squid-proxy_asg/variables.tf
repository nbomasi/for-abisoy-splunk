variable "ami_name_filter" {
  description = "Filter for AMI name"
  type        = string
}

variable "ami_owner" {
  description = "AMI owner ID"
  type        = string
}

variable "vpc_id" {
  description = "VPC Id"
  type        = string
}

variable "pod" {
  description = "Pod identifier"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., sandbox, staging, production)"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "squid_config" {
  description = "Squid Proxy configuration"
  type        = string
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
}

variable "squid_desired_capacity" {
  description = "Desired number of instances"
  type        = number
}

variable "squid_asg_min_size" {
  description = "Minimum number of instances"
  type        = number
}

variable "squid_asg_max_size" {
  description = "Maximum number of instances"
  type        = number
}

variable "squid_subnets_ids" {
  description = "List of subnets"
  type        = list(string)
}

variable "squid_scale_up_adjustment" {
  description = "Adjustment for scale up"
  type        = number
}

variable "squid_scale_down_adjustment" {
  description = "Adjustment for scale down"
  type        = number
}