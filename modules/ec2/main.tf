data "aws_ami" "latest_packer_ami" {
  most_recent = true
  owners      = [var.ami_owner]

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }
}

resource "aws_instance" "ec2_instance" {
  count                      = var.instance_count
  ami                        = data.aws_ami.latest_packer_ami.id
  instance_type              = var.instance_type
  key_name                   = var.key_name
  subnet_id                  = element(var.subnet_ids, count.index % length(var.subnet_ids))
  vpc_security_group_ids     = var.vpc_security_group_ids
  associate_public_ip_address = true

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
