module "allow_all_sg" {
  source           = "../16-aws-sg-module"
  common_tags      = var.common_tags
  project_name     = var.project_name
  sg_tags          = var.sg_tags
  sg_name          = "Allow_All_SG"
  sg_description   = "Allowing all ports from internet"
  sg_ingress_rules = var.sg_ingress_rules
  vpc_id           = local.vpc_id
}