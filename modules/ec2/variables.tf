variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "Type of instance to launch"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
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

variable "pod" {
  description = "Pod identifier"
  type        = string
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
}

variable "root_volume_type" {
  description = "Root volume type (e.g., gp2, gp3, io1)"
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

variable "vpc_id" {
  description = "VPC ID where the instances will be deployed"
  type        = string
}
