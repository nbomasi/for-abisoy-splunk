terraform {
  backend "s3" {
    bucket  = var.bucket_name
    key     = var.state_file_key
    region  = var.aws_region
    encrypt = true
  }
}


