variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "my-terraform-state-bucket"
}

variable "state_file_key" {
  description = "The path to the state file inside the S3 bucket"
  type        = string
  default     = "path/to/my/terraform.tfstate"
}


variable "aws_region" {
  description = "The AWS region where the S3 bucket is located."
  type        = string
  default     = "us-east-1"
}