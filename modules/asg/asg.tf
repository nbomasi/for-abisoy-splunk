resource "aws_autoscaling_group" "prometheus_grafana_asg" {
  launch_template {
    id      = aws_launch_template.prometheus_grafana_lt.id
    version = "$Latest"
  }

  min_size         = var.asg-min-size
  desired_capacity = var.asg-desired-capacity
  max_size         = var.asg-max-size

  vpc_zone_identifier = var.subnet-ids

  #target_group_arns = [var.target_group_arn] # Optional: If you're attaching this ASG to a load balancer

  # Health check settings
  health_check_type         = var.health-check-type
  health_check_grace_period = 300


  # Optional: Scaling policies can be added here
  tag {
    key                 = "Name"
    value               = "pod-b-prometheus-grafana_lt-${environment}"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "splunk_new_asg" {
  launch_template {
    id      = aws_launch_template.splunk_new_lt.id
    version = "$Latest"
  }

  min_size         = var.asg-min-size
  desired_capacity = var.asg-desired-capacity
  max_size         = var.asg-max-size

  vpc_zone_identifier = var.subnet-ids

  #target_group_arns = [var.target_group_arn] # Optional: If you're attaching this ASG to a load balancer

  # Health check settings
  health_check_type         = var.health-check-type
  health_check_grace_period = 300


  # Optional: Scaling policies can be added here
  tag {
    key                 = "Name"
    value               = "pod-b-splunk_new_lt-${environment}"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
