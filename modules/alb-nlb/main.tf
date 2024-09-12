resource "aws_security_group" "alb_sg" {
  vpc_id = var.vpc_id
  name   = "alb_sg"

  // Egress rules
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  // Ingress rule for HTTP (port 80)
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  // Ingress rule for HTTPS (port 443)
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# ALB resource
resource "aws_lb" "alb" {
  count = var.create_alb ? 1 : 0

  name               = var.alb-name
  internal           = var.internal
  load_balancer_type = var.load-balancer-type-alb
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.subnets

  enable_deletion_protection = false

  tags = {
    Name        = "alb-${var.environment}"
    Environment = var.environment
  }
}

# NLB resource
resource "aws_lb" "nlb" {
  count = var.create_nlb ? 1 : 0

  name               = var.nlb-name
  internal           = var.internal
  load_balancer_type = var.load-balancer-type-nlb
  subnets            = var.subnets

  enable_deletion_protection = false
  tags = {
    Name        = "nlb-${var.environment}"
    Environment = var.environment

  }
}
