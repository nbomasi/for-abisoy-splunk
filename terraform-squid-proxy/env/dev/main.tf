module "asg_squid_proxy" {
  source = "../../modules/asg"

  ami_id               = var.ami_id
  instance_type        = var.instance_type
  key_name             = var.key_name
  root_volume_size     = var.root_volume_size
  desired_capacity     = var.desired_capacity
  min_size             = var.min_size
  max_size             = var.max_size
  subnets              = var.subnets
  squid_config         = file("${path.module}/squid.conf")
  scale_up_adjustment  = var.scale_up_adjustment
  scale_down_adjustment = var.scale_down_adjustment
}