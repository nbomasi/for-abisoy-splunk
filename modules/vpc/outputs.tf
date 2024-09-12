output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.private[*].id
}




output "public_route_table_ids" {
  description = "The IDs for the Public Route Table"
  value       = aws_route_table.public-rtb.id
}

output "transit_gateway_id" {
  description = "The IDs for the Transit Gateway"
  value       = aws_ec2_transit_gateway.transit_gateway.id
}