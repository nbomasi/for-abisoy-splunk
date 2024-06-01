resource "aws_s3_bucket" "xterns" {
  bucket = "xterns-bucket"

  tags = {
    Name        = "Xterns bucket"
    Environment = "Dev"
  }
}