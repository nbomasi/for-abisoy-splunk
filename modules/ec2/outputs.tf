output "instance_ids" {
  description = "The IDs of the instances"
  value       = aws_instance.ec2_instance[*].id
}


