variable "nlb_name" {
  description = "The name of the NLB"
  type        = string
}
variable "internal" {
  description = "Boolean to determine if the NLB is internal or internet-facing"
  type        = bool
  default     = false
}

variable "subnets" {
  description = "List of subnet IDs where the NLB will be deployed"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "enable_deletion_protection" {
  description = "Whether deletion protection is enabled for the NLB"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Environment (e.g., sandbox, staging, production)"
  type        = string
}
