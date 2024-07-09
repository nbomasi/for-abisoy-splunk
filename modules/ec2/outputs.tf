output "instance_ids" {
  description = "IDs of the EC2 instances"
  value       = aws_instance.ec2_instance[*].id
}
output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.asg[*].name
}