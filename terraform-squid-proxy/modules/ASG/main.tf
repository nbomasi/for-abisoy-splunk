resource "aws_launch_template" "squid_proxy" {
  name_prefix   = "squid-proxy-"
  image_id      = var.ami_id
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

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "squid-proxy"
    }
  }
}

resource "aws_autoscaling_group" "squid_proxy_asg" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = var.subnets
  launch_template {
    id      = aws_launch_template.squid_proxy.id
    version = "$Latest"
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "squid-proxy"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  scaling_adjustment     = var.scale_up_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.squid_proxy_asg.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale_down"
  scaling_adjustment     = var.scale_down_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.squid_proxy_asg.name
}