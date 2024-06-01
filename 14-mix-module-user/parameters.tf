resource "aws_ssm_parameter" "vpc_id_param" {
  name  = "/roboshop/dev/vpc_id"
  type  = "String"
  value = local.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/roboshop/dev/public_subnet_ids"
  type  = "String"
  value = join(",", local.public_subnet_ids)
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/roboshop/dev/private_subnet_ids"
  type  = "String"
  value = join(",", local.private_subnet_ids)
}

resource "aws_ssm_parameter" "database_subnet_ids" {
  name  = "/roboshop/dev/database_subnet_ids"
  type  = "String"
  value = join(",", local.database_subnet_ids)
}

resource "aws_ssm_parameter" "allow_all_sg_id" {
  name  = "/roboshop/dev/allow_all_sg_id"
  type  = "String"
  value = local.security_group_id
}