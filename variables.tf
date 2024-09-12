variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "ami_owner" {
  description = "AMI owner ID"
  type        = string
}

variable "ami_name_filter" {
  description = "Filter for AMI name"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
}

variable "environment" {
  description = "Environment (e.g., sandbox, staging, production)"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
}

variable "key_name" {
  description = "Key name for EC2 instances"
  type        = string
}

variable "pod" {
  description = "Pod identifier"
  type        = string
}

variable "preferred_number_of_private_subnets" {
  description = "Preferred number of private subnets"
  type        = number
}

variable "preferred_number_of_public_subnets" {
  description = "Preferred number of public subnets"
  type        = number
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
}

variable "root_volume_type" {
  description = "Root volume type"
  type        = string
}

variable "default_tags" {
  description = "A map of default tags to assign to resources"
  type        = map(string)
}

variable "vpc_security_groups" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "use_asg" {
  description = "Flag to toggle between standalone EC2 instance and Auto Scaling Group"
  type        = bool
  default     = false
}

variable "asg_min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "asg_desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group"
  type        = number
  default     = 1
}


variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "my-terraform-state-bucket"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "terraform-state-lock"
}

variable "user_name" {
  description = "The name of the IAM user"
  type        = string
}

variable "aws_account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "s3-policy_name" {
  description = "The name of the IAM policy"
  type        = string
}

variable "dynamodb-policy_name" {
  description = "The name of the IAM policy"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "alb_name" {
  description = "The name of the ALB"
  type        = string
}
variable "nlb_name" {
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

variable "ingress_rules" {
  description = "List of ingress rules for the ALB security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "amazon_side_asn" {
  description = "Private Autonomous System Number (ASN) for the Amazon side of a BGP session"
  type        = number
}

# variable "ami-id" {
#   type        = string
#   description = "The ID of the Ubuntu AMI to use"
# }

variable "instance-type" {
  type        = string
  description = "The EC2 instance type"

}

# variable "subnet-ids" {
#   type        = list(string)
#   description = "List of subnet IDs to launch the instances in"
# }

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

# variable "vpc-id" {
#   type = string

#}


variable "root-volume-size" {
  type = number

}

variable "root-volume-type" {
  type = string

}

variable "health-check-type" {
  type = string

} # variables for prometheus and grafana asg
