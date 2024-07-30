output "dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.alb.dns_name
}

output "arn" {
  description = "The ARN of the ALB"
  value       = aws_lb.alb.arn
}

output "id" {
  description = "The ID of the ALB"
  value       = aws_lb.alb.id
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}