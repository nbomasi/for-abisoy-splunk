resource "aws_security_group" "prometheus_grafana_sg" {
  name   = "pod-b-prometheus_grafana_sg-${var.environment}"
  vpc_id = var.vpc-id

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict to necessary IP ranges
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict to necessary IP ranges
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict to necessary IP ranges
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "pod-b-prometheus_grafana_sg-${var.environment}"
  }
}


resource "aws_security_group" "splunk_new_sg" {
  name   = "pod-b-splunk_new_lt-${var.environment}"
  vpc_id = var.vpc-id

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict to necessary IP ranges
  }

  ingress {
    from_port   = 9997
    to_port     = 9997
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict to necessary IP ranges
  }

  ingress {
    from_port   = 8089
    to_port     = 8089
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict to necessary IP ranges
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict to necessary IP ranges
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "pod-b-splunk_new_lt-${var.environment}"
  }
}
