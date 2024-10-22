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
output "transit_gateway_id" {
  description = "The IDs of the instances"
  value       = module.vpc.transit_gateway_id
}

output "zone_id" {
  description = "The ID of the hosted zone"
  value       = module.aws_route53_zone.zone_id
}

output "nameservers" {
  description = "The nameservers of the hosted zone"
  value       = module.aws_route53_zone.nameservers
}

output "alb_dns_name" {
  value = module.alb.dns_name
}

output "nlb_arn" {
  value = module.nlb.nlb_arn
}

output "nlb_dns_name" {
  value = module.nlb.nlb_dns_name
}

output "alb_security_group_id" {
  value = module.alb.alb_sg_id
}
output "nlb_security_group_id" {
  value = module.nlb.nlb_sg_id
}

output "alb_arn" {
  value = module.alb.alb_arn
}

# output "squid-proxy_asg_name" {
#   description = "The name of the ASG"
#   value       = module.asg_squid_proxy.squid-proxy_asg_name
# }

# output "squid-proxy_launch_template_id" {
#   description = "The ID of the launch template"
#   value       = module.asg_squid_proxy.squid-proxy_launch_template_id
# }

output "squid-proxy_zone_name" {
  description = "The ID of the Squid-proxy hosted zone"
  value       = module.aws_route53_zone.squid-proxy_zone_name
}
