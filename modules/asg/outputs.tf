output "asg_name" {
  description = "The name of the Auto Scaling Group"
  value       = aws_autoscaling_group.prometheus_grafana_asg.name
}

output "launch_template_id" {
  description = "The ID of the Launch Template"
  value       = aws_launch_template.prometheus_grafana_lt.id
}

# Data source to fetch instances by tags
data "aws_instances" "asg_instances" {
  filter {
    name   = "tag:Name"
    values = ["Prometheus-Grafana-Instance"]
  }
}

# Output the public IPs
output "instance_public_ips" {
  description = "Public IP addresses of instances in the ASG"
  value       = data.aws_instances.asg_instances.public_ips
}

output "splunk-security_group_id" {
  description = "splunk security group id to be use for loadbalancer"
  value       =  aws_security_group.splunk_new_sg.id
}
