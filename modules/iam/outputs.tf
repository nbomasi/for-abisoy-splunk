output "iam_role_arn" {
  description = "The ARN of the IAM role"
  value       = aws_iam_role.terraform_role.arn
}
