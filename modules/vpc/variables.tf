variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC."
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
  type        = bool
  default     = true
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
}


variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}


