output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "instance_ids" {
  description = "The IDs of the instances"
  value       = module.ec2_instance.instance_ids
}

output "asg_name" {
  description = "The name of the Auto Scaling Group"
  value       = module.ec2_instance.asg_name
}
