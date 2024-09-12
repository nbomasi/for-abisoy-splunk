# NLB Resource
resource "aws_lb" "nlb" {
  name                       = var.nlb_name
  internal                   = var.internal
  load_balancer_type         = "network"
  subnets                    = var.subnets
  security_groups            = [aws_security_group.nlb_sg.id]
  enable_deletion_protection = var.enable_deletion_protection

  tags = merge(
    var.tags,
    {
      Name = var.nlb_name
    },
  )
}

# Security group for NLB (optional, for completeness, though typically NLBs don't require SGs)
resource "aws_security_group" "nlb_sg" {
  vpc_id = var.vpc_id
  name   = "nlb_sg"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "nlb-sg"
    },
  )
}
