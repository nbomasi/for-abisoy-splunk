variable "alb_name" {
  description = "The name of the ALB"
  type        = string
}

variable "internal" {
  description = "Whether the ALB is internal or external"
  type        = bool
}

variable "vpc_id" {
  description = "The VPC ID in which to create the ALB"
  type        = string
}

variable "subnets" {
  description = "List of subnets to associate with the ALB"
  type        = list(string)
}

variable "alb_security_groups" {
  description = "List of security group IDs to associate with the ALB"
  type        = list(string)
}


variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}


variable "ingress_rules" {
  description = "List of ingress rules for the ALB security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}
