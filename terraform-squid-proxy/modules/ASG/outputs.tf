output "asg_name" {
  description = "The name of the ASG"
  value       = aws_autoscaling_group.squid_proxy_asg.name
}

output "launch_template_id" {
  description = "The ID of the launch template"
  value       = aws_launch_template.squid_proxy.id
}