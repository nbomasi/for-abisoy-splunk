# Define IAM Role
resource "aws_iam_role" "terraform_role" {
  name = var.role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com" # Example service; adjust based on actual use case
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Define IAM User
resource "aws_iam_user" "terraform_user" {
  name = var.user_name
}

# Define IAM Policy for S3
resource "aws_iam_policy" "terraform_s3_policy" {
  name        = var.s3-policy_name
  description = "Policy to allow Terraform to read and write state files in S3"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      }
    ]
  })
}

# Define IAM Policy for DynamoDB
resource "aws_iam_policy" "terraform_dynamodb_policy" {
  name        = var.dynamodb-policy_name
  description = "Policy to allow Terraform to manage locks in DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:DeleteItem",
          "dynamodb:DescribeTable",
          "dynamodb:Scan"
        ],
        Resource = "arn:aws:dynamodb:${var.aws_region}:${var.aws_account_id}:table/${var.dynamodb_table_name}"
      }
    ]
  })
}

# Define Transit Gateway Policy
resource "aws_iam_policy" "transit_gateway_policy" {
  name        = "TransitGatewayPolicy"
  description = "Policy for managing Transit Gateway"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:CreateTransitGateway",
          "ec2:DeleteTransitGateway",
          "ec2:DescribeTransitGateways",
          "ec2:CreateTransitGatewayAttachment",
          "ec2:DeleteTransitGatewayAttachment",
          "ec2:DescribeTransitGatewayAttachments"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach S3 Policy to IAM User
resource "aws_iam_user_policy_attachment" "terraform_user_s3_policy_attachment" {
  user       = aws_iam_user.terraform_user.name
  policy_arn = aws_iam_policy.terraform_s3_policy.arn
}

# Attach DynamoDB Policy to IAM User
resource "aws_iam_user_policy_attachment" "terraform_user_dynamodb_policy_attachment" {
  user       = aws_iam_user.terraform_user.name
  policy_arn = aws_iam_policy.terraform_dynamodb_policy.arn
}

# Attach S3 Policy to IAM Role
resource "aws_iam_role_policy_attachment" "terraform_role_s3_policy_attachment" {
  role       = aws_iam_role.terraform_role.name
  policy_arn = aws_iam_policy.terraform_s3_policy.arn
}

# Attach DynamoDB Policy to IAM Role
resource "aws_iam_role_policy_attachment" "terraform_role_dynamodb_policy_attachment" {
  role       = aws_iam_role.terraform_role.name
  policy_arn = aws_iam_policy.terraform_dynamodb_policy.arn
}

# Attach Transit Gateway Policy to IAM Role
resource "aws_iam_role_policy_attachment" "transit_gateway_policy_attachment" {
  role       = aws_iam_role.terraform_role.name
  policy_arn = aws_iam_policy.transit_gateway_policy.arn
}