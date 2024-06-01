module "mysql_instance" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami                    = data.aws_ami.devops_ami.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.mysql_sg_id.value]
  # It should be in Database Subnet
  subnet_id = local.database_subnet_id
  user_data = file("mysql.sh")

  tags = merge(
    {
      Name = "mysql"
      Component = "MYSQL"
    },
    var.common_tags
  )
}

module "records" {
  source    = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = var.zone_name
  records = [
    {
      name = "mysql"
      type = "A"
      ttl  = 1
      records = [
        module.mysql_instance.private_ip
      ]
    }
  ]
}
