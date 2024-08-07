# Create private route table
resource "aws_route_table" "private-rtb" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    {
      Name = format("devops-%s-%s-private-route-table-%s", var.pod, local.timestamp, var.environment)
    }
  )

}
# Associate all private subnets to the private route table
resource "aws_route_table_association" "private-subnets-assoc" {
  count          = length(aws_subnet.private[*].id)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private-rtb.id

}

# Associate Route Table with Public Subnets
resource "aws_route_table_association" "public" {
  count          = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Create public route table
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    {
      Name = format("devops-%s-%s-public-route-table-%s", var.pod, local.timestamp, var.environment)
    }
  )

}
