variable "ami-id" {
  type        = string
  description = "The ID of the Ubuntu AMI to use"
}

variable "instance-type" {
  type        = string
  description = "The EC2 instance type"

}

variable "subnet-ids" {
  type        = list(string)
  description = "List of subnet IDs to launch the instances in"

}

variable "asg-min-size" {
  type        = number
  description = "Minimum size of the Auto Scaling Group"

}

variable "asg-max-size" {
  type        = number
  description = "Maximum size of the Auto Scaling Group"

}

variable "asg-desired-capacity" {
  type        = number
  description = "Desired capacity of the Auto Scaling Group"

}

variable "vpc-id" {
  type = string

}


variable "root-volume-size" {
  type = number

}

variable "root-volume-type" {
  type = string

}

variable "health-check-type" {
  type = string

}

variable "ami_owner" {

}

variable "ami_name_filter" {

}

variable "environment" {
  description = "Environment (e.g., sandbox, staging, production)"
  type        = string
}

variable "target_group_arns" {
  description = "target group for splunk indexer to be used in splunk asg"
}