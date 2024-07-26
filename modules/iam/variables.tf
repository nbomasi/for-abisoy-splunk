variable "user_name" {
  description = "The name of the IAM user"
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

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
  type        = string
}


variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}


variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

