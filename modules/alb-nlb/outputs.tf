# Output the LB ARN if created
output "alb_arn" {
  value       = var.create_alb ? aws_lb.alb[0].arn : null
  description = "The ARN of the created ALB"
}

output "nlb_arn" {
  value       = var.create_nlb ? aws_lb.nlb[0].arn : null
  description = "The ARN of the created NLB"
}
