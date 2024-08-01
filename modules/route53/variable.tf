variable "environment" {
  description = "Environment (e.g., sandbox, staging, production)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the instances will be deployed"
  type        = string
}

variable "pod" {
  description = "Pod identifier"
  type        = string
}
