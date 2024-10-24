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

## Splunk Network Load balancer resources.
resource "aws_lb" "splunk_nlb_indexer" {
  name               = "pod-b-splunk-indexer-nlb-${var.environment}"
  internal           = var.internal
  load_balancer_type = "network"
  subnets            = var.subnets # Update with your subnet IDs
}

# resource "aws_lb_target_group" "splunk_tg" {
#   name        = "pod-b-splunk_indexer_nlb-tg-${var.environment}"
#   port        = 9997
#   protocol    = "TCP"
#   vpc_id      = var.vpc_id  # Update with your VPC ID
#   target_type = "instance"
# }

resource "aws_lb_target_group" "splunk_indexer_tg" {
  name     = "pod-b-splunk-indexer-tg-${var.environment}"
  port     = 9997
  protocol = "TCP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }

  target_type = "instance" # Ensure this is "instance" for EC2 instances
}


# resource "aws_lb_target_group_attachment" "splunk_attachment" {
#   target_group_arn = aws_lb_target_group.splunk_indexer_tg.arn
#   target_id        = "your-ec2-instance-id"  # Update with your EC2 instance ID where Splunk is installed
#   port             = 9997
# }

resource "aws_lb_listener" "splunk_listener" {
  load_balancer_arn = aws_lb.splunk_nlb_indexer.arn
  port              = 9997
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.splunk_indexer_tg.arn
  }
}

