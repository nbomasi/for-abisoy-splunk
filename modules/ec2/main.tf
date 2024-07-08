data "aws_ami" "latest_packer_ami" {
  most_recent = true
  owners      = [var.ami_owner]

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }
}

resource "aws_security_group" "security_group" {
  name = "Project Security Groups"
  description = "EC2 Instance Security groups"
  vpc_id = var.vpc_id
  ingress = [
    for port in var.vpc_security_groups : {
      description = "TLS from VPC"
      from_port = port
      to_port = port
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}

resource "aws_instance" "ec2_instance" {
  count                      = var.instance_count
  ami                        = data.aws_ami.latest_packer_ami.id
  instance_type              = var.instance_type
  key_name                   = var.key_name
  subnet_id                  = element(var.subnet_ids, count.index % length(var.subnet_ids))
  vpc_security_group_ids     = [aws_security_group.security_group.id]
  associate_public_ip_address = true

  root_block_device {
    encrypted = true
    volume_type = var.root_volume_type
    volume_size = var.root_volume_size
  }

  tags = merge(
    var.tags,
    {
      Name        = format("devops-%s-%s-%s-instance-%d", var.pod, local.timestamp, var.environment, count.index + 1)
      Environment = var.environment
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

locals {
  timestamp = formatdate("YYYYMM", timestamp())
}
