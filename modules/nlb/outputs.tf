output "nlb_arn" {
  description = "The ARN of the NLB"
  value       = aws_lb.nlb.arn
}

output "nlb_dns_name" {
  description = "The DNS name of the NLB"
  value       = aws_lb.nlb.dns_name
}

output "nlb_sg_id" {
  value = aws_security_group.nlb_sg.id
}
