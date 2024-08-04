# ALB Resource
resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  subnets            = var.subnets
  security_groups    = [aws_security_group.alb_sg.id]
  tags               = var.tags
}

# Security group for alb
resource "aws_security_group" "alb_sg" {
  vpc_id = var.vpc_id
  name   = "alb_sg"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  tags = merge(
    var.tags,
    {
      Name = "alb-sg"
    },
  )
}
