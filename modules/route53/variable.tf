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

variable "alias_records" {
  description = "List of Alias records"
  type = list(object({
    name                   = string
    zone_id                = string
    evaluate_target_health = bool
    alias_name             = string
  }))
  default = []
}

variable "alb_arn" {
  description = "Application load balancer Arn"
}