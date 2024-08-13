# Define the input variable
variable "create_alb" {
  description = "Set to true to create ALB, false to skip"
  type        = bool
  default     = false
}

variable "create_nlb" {
  description = "Set to true to create NLB, false to skip"
  type        = bool
  default     = false
}

variable "alb-name" {
  type        = string
  description = "Name of Application Load balancer"
  default     = "my-alb"
}

variable "nlb-name" {
  type        = string
  description = "Name of Application Load balancer"
  default     = "my-nlb"
}

variable "internal" {
  type        = bool
  description = "whether the load balancer is internal"
  default = false
}

variable "load-balancer-type-alb" {
  type        = string
  description = "Type of load balancer to create (ALB or NLB)"
  default = "application"
}

variable "load-balancer-type-nlb" {
  type        = string
  description = "Type of load balancer to create (ALB or NLB)"
  default = "network"
}

variable "subnets" {
  type = list(string)
  description = "calling subnets from root main.tf"
}
variable "vpc_id" {
  type = string
  description = "calling vpc_id from root main.tf"
}

variable "environment" {
  type = string
  description = "calling environment from root main.tf"
}
 