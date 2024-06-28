variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
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

variable "vpc_security_group_ids" {
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
