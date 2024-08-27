data "aws_ami" "latest_packer_ami" {
  most_recent = true
  owners      = [var.ami_owner]

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }
}

#tfsec:ignore:aws-ec2-no-public-egress-sgr
#tfsec:ignore:aws-ec2-no-public-ingress-sgr
resource "aws_security_group" "squid-proxy_sg" {
  name = "squid-proxy-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "Squid Proxy Port"
    from_port = 3128
    to_port = 3128
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name        = format("devops-%s-%s-%s-squid-proxy_sg", var.pod, local.timestamp, var.environment)
      Environment = var.environment
    }
  )

}

resource "aws_launch_template" "squid_proxy" {
  name_prefix   = "squid-proxy-"
  image_id      = data.aws_ami.latest_packer_ami.id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = base64encode(templatefile("${path.module}/userdata.tpl", {
    squid_config = var.squid_config
  }))


  lifecycle {
    create_before_destroy = true
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      delete_on_termination = true
      volume_size           = var.root_volume_size
    }
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups = [aws_security_group.squid-proxy_sg.id]
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      var.tags,
      {
        Name = format("devops-%s-%s-%s-squid-proxy_launch-template", var.pod, local.timestamp, var.environment)
        Environment = var.environment
      }
    )
  }
}

resource "aws_autoscaling_group" "squid_proxy_asg" {
  desired_capacity     = var.squid_desired_capacity
  max_size             = var.squid_asg_max_size
  min_size             = var.squid_asg_min_size
  vpc_zone_identifier  = var.squid_subnets_ids
  launch_template {
    id      = aws_launch_template.squid_proxy.id
    version = "$Latest"
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = format("devops-%s-%s-%s-squid-proxy-asg", var.pod, local.timestamp, var.environment)
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  scaling_adjustment     = var.squid_scale_up_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.squid_proxy_asg.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale_down"
  scaling_adjustment     = var.squid_scale_down_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.squid_proxy_asg.name
}

locals {
  timestamp = formatdate("YYYYMM", timestamp())
}
