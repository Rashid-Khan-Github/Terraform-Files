module "ec2_vpn" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami                    = data.aws_ami.devops_ami.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]

  # Subnet Id is optional. If not given, it will allocate default subnet in default vpc
  # subnet_id              = local.public_subnet_ids[0]     # Public subnet in 1a region

  tags = merge(
    {
      Name = "RoboShop-VPN"
    },
    var.common_tags
  )
}