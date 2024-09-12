variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for public subnets"
  type        = list(any)
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for private subnets"
  type        = list(any)
}

variable "preferred_number_of_public_subnets" {
  type        = number
  description = "Number of public subnets"
}

variable "preferred_number_of_private_subnets" {
  type        = number
  description = "Number of private subnets"
}

variable "availability_zones" {
  description = "A list of availability zones for the subnets"
  type        = list(string)
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

variable "amazon_side_asn" {
  description = "Private Autonomous System Number (ASN) for the Amazon side of a BGP session"
  type        = number
}

variable "internet_gateway_id" {
  description = "ID of an existing Internet Gateway (optional)"
  type        = string
  default     = ""
}
