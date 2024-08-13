provider "aws" {
  region = "us-east-1" # Specify the AWS region where you want to deploy the resources
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}