# Create a Transit Gateway
resource "aws_ec2_transit_gateway" "transit_gateway" {
  description                     = "Transit Gateway to connect multiple VPCs"
  default_route_table_association = "enable"
  amazon_side_asn                 = var.amazon_side_asn

  tags = merge(
    var.tags,
    {
      Name = format("devops-%s-%s-transit-gateway-%s", var.pod, local.timestamp, var.environment)
    }
  )
}

# Create a transit gateway attachment and attach the transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "transit_gateway_vpc_attachment" {
  subnet_ids         = [for subnet in aws_subnet.public : subnet.id]
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id             = aws_vpc.main.id
  dns_support        = "enable"
  ipv6_support       = "enable"

  tags = merge(
    var.tags,
    {
      Name = format("devops-%s-%s-transit-gateway-attachment-%s", var.pod, local.timestamp, var.environment)
    }
  )

}

# Create a route table for the Transit Gateway
resource "aws_route_table" "transit-gateway-rtb" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    {
      Name = format("devops-%s-%s-transit-gateway-route-table-%s", var.pod, local.timestamp, var.environment)
    }
  )
}

# Create a route for the Transit Gateway Route
resource "aws_route" "transit_gateway_route" {
  route_table_id         = aws_route_table.transit-gateway-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = aws_ec2_transit_gateway.transit_gateway.id

}