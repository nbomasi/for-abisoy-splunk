variable "ami_id" {
  description = "AMI ID for Squid Proxy"
  type        = string
  default     = "ami-0ae8f15ae66fe8cda"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key name"
  type        = string
  default     = "podb"
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 10
}

variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of instances"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances"
  type        = number
  default     = 2
}

variable "subnets" {
  description = "List of subnets"
  type        = list(string)
  default     = ["subnet-07409894995c5060f"] 
}

variable "scale_up_adjustment" {
  description = "Adjustment for scale up"
  type        = number
  default     = 1
}

variable "scale_down_adjustment" {
  description = "Adjustment for scale down"
  type        = number
  default     = -1
}