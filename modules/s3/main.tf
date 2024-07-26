resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "retain-state-files"
    enabled = true

    noncurrent_version_expiration {
      days = 30
    }
  }

  tags = var.tags
}
